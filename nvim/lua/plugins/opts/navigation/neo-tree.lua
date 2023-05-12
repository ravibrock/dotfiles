return {
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = true,
    use_libuv_file_watcher = true,
  },
  default_component_configs = {
    indent = {
      with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
  },
}
