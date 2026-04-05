--- smooth cursor ---

require('utils').pkg_install({
  { src = 'sphamba/smear-cursor.nvim', name = 'smear_cursor' }
})

require('utils').pkg_load('smear_cursor', {
  stiffness = 0.6,
  trailing_stiffness = 0.8,
  distance_stop_animating = 0.3,
  smear_between_buffers = false
})
