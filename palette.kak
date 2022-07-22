hook global ModuleLoaded palette %{
  palette-enable
}

provide-module palette %{
  declare-option -hidden range-specs palette
  add-highlighter shared/palette ranges palette
  define-command palette-enable -docstring 'Enable color preview' %{
    add-highlighter global/palette ref palette
    hook -group palette global NormalIdle .* palette-update
  }
  define-command palette-disable -docstring 'Disable color preview' %{
    remove-highlighter global/palette
    remove-hooks global palette
  }
  define-command -hidden palette-update %{
    try %{
      evaluate-commands -draft -save-regs '/bdf' %{
        execute-keys '<space>gtGb'
        set-register / '(?:#|rgb:)([0-9A-Fa-f]{6})'
        execute-keys 's<ret>'
        set-option window palette %val{timestamp}
        evaluate-commands -no-hooks -draft -itersel %{
          # Save selection description
          set-register d %val{selection_desc}
          # Select value
          execute-keys '1s<ret>'
          # Save value
          set-register b %reg{.}
          set-register f %sh(printf '%s' "$kak_main_reg_dot" | tr '0123456789ABCDEFabcdef' 'fedcba9876543210543210')
          set-option -add window palette "%reg{d}|rgb:%reg{f},rgb:%reg{b}"
        }
      }
    } catch %{
      unset-option window palette
    }
  }
}

require-module palette
