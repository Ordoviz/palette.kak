declare-option -hidden range-specs palette

define-command -hidden palette-update %{
  try %{
    evaluate-commands -draft -save-regs '/DV' %{
      execute-keys '<space>;gtGb'
      set-register / '(?:#|rgb:)([0-9A-Fa-f]{6})'
      execute-keys 's<ret>'
      set-option window palette %val(timestamp)
      evaluate-commands -no-hooks -draft -itersel %{
        # Save description
        set-register D %val(selection_desc)
        # Select value
        execute-keys '1s<ret>'
        # Save value
        set-register V %reg(.)
        set-option -add window palette "%reg(D)|default,rgb:%reg(V)"
      }
    }
  } catch %{
    unset-option window palette
  }
}

define-command palette-enable -docstring 'Enable color preview' %{
  add-highlighter window/palette ranges palette
  hook -group palette window NormalIdle '' palette-update
}

define-command palette-disable -docstring 'Disable color preview' %{
  remove-highlighter window/palette
  remove-hooks window palette
}
