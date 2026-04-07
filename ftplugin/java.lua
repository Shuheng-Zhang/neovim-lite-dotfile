-- Indent configuration --
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument = {
  foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  },
  hover = {
    contentFormat = { "markdown" },
    dynamicRegistration = false
  }
}

local cmp_capabilities = require("blink.cmp").get_lsp_capabilities()

local root_markers = { "pom.xml", "build.gradle", "mvnw", "gradlew" }
local root_dir = require("jdtls.setup").find_root(root_markers)

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/workspace-root/" .. project_name
vim.fn.mkdir(workspace_dir, "p")

local jdtls_bundles = {
  -- Debugger
  vim.fn.glob("$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
  -- Testing
  (table.unpack or unpack)(vim.split(vim.fn.glob("$MASON/share/java-test/*.jar"), "\n", {})),
}

local jdtls_settings = {
  java = {
    eclipse = { downloadSources = true },
    maven = { downloadSources = true },
    gradle = { downloadSources = true },
    implementationsCodeLens = { enabled = true },
    referencesCodeLens = { enabled = true },
    inlayHints = { parameterNames = { enabled = "all" } },
    signatureHelp = { enabled = true },
    saveActions = {
      organizeImports = true,
    },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    configuration = {
      updateBuildConfiguration = "interactive",
      runtimes = {
        {
          name = "JavaSE-17",
          path = "/Library/Java/JavaVirtualMachines/zulu-17.jdk"
        },
        {
          name = "JavaSE-21",
          path = "/Library/Java/JavaVirtualMachines/zulu-21.jdk",
        },
        {
          name = "JavaSE-25",
          path = "/Library/Java/JavaVirtualMachines/zulu-25.jdk",
        },
      },
    },
    format = {
      enabled = true,
      settings = {
        url = vim.fn.stdpath("config") .. "/java-code-style-intellij.xml",
        profile = "Default",
      },
    },
    cleanup = {
      convertFunctionalInterfaces = true, -- 允许自动转换为 lambda
      simplifyLambdaExpression = true,    -- 简化 lambda
    },
    compile = {
      annotationProcessing = {
        enabled = true,
      },
    },
  },
}

local jdtls_cmd = {
  "java",
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
  "-Xms1g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens",
  "java.base/java.util=ALL-UNNAMED",
  "--add-opens",
  "java.base/java.lang=ALL-UNNAMED",
  "-jar",
  vim.fn.expand("$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar"),
  "-configuration",
  vim.fn.expand("$MASON/share/jdtls/config"),
  "-data",
  workspace_dir,
}
vim.api.nvim_create_autocmd("LspAttach", {
  pattern = "*.java",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- ensure that only the jdtls client is activated
    if client and client.name == "jdtls" then
      -- Enable DAP
      require("jdtls.dap").setup_dap_main_class_configs()
      client.handlers = {
        ["textDocument/hover"] = function(_, result, ctx, config)
          if result and result.contents then
            -- print("handling document...")
            if type(result.contents) == 'table' then
              for i, content in ipairs(result.contents) do
                -- print("contents = " .. result.contents)
                if type(content) == 'string' and content:match("\\(jdt://.*\\)") then
                  result.contents[i] = "()" -- 或者返回空字符串，表示不显示
                end
              end
            elseif type(result.contents) == 'string' and result.contents:match("\\(jdt://.*\\)") then
              -- print("contents = " .. result.contents)
              result.contents = "()" -- 如果是字符串类型，则直接清空
            end
          end
          -- 默认调用原有的 hover 处理器
          vim.lsp.handlers["textDocument/hover"](_, result, ctx, config)
        end
      }
    end
  end,
})

local config = {
  cmd = jdtls_cmd,
  filetypes = { "java" },
  root_dir = root_dir,
  root_markers = root_markers,
  capabilities = vim.tbl_deep_extend("force", capabilities, cmp_capabilities or {}),
  settings = jdtls_settings,
  init_options = {
    bundles = jdtls_bundles,
  },
}

vim.lsp.config("jdtls", config)
vim.lsp.enable("jdtls")

-- Check is Spring Boot based or not
-- then enable spring boot support
if root_dir then
  for _, file in ipairs({ root_dir .. "/pom.xml", root_dir .. "/build.gradle" }) do
    local f = io.open(file, "r")
    if f then
      local content = f:read("*a")
      f:close()
      if content:match("spring%-boot") then
        vim.list_extend(jdtls_bundles, require("spring_boot").java_extensions())
      end
    end
  end
end
