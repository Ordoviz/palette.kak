declare-option -hidden range-specs palette

define-command -hidden palette-update %{
  try %{
    evaluate-commands -draft -save-regs '/BDF' %{
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
        set-register B %reg(.)
        set-register F %sh(printf '%s' "$kak_main_reg_dot" | tr '0123456789ABCDEFabcdef' 'fedcba9876543210543210')
        set-option -add window palette "%reg(D)|rgb:%reg(F),rgb:%reg(B)"
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
