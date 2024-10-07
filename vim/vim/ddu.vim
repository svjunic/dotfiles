" ffマッピング
autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR> <Cmd>call ddu#ui#do_action('itemAction')<CR>
  nnoremap <buffer><silent> o <Cmd>call ddu#ui#do_action('itemAction')<CR>
  nnoremap <buffer><silent> s <Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<CR>
  nnoremap <buffer><silent> t <Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'tabnew'}})<CR>
  nnoremap <buffer><silent> i <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> <Space> <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> <Esc> <Cmd>call ddu#ui#do_action('quit')<CR>
  nnoremap <buffer><silent> q <Cmd>call ddu#ui#do_action('quit')<CR>
endfunction

" https://github.com/tamago3keran/dotfiles_for_docker/blob/base/.local/share/dein/plugins/ddu.vim
" 参考にさせてもらった感謝
" ffのui
call ddu#custom#patch_global(#{
    \   ui: 'ff',
    \   uiParams: #{
    \     ff: #{
    \       startAutoAction: v:true,
    \       autoAction: #{ name: 'preview' },
    \       prompt: '> ',
    \       split: 'floating',
    \       floatingBorder: 'rounded',
    \       floatingTitle: ' Fuzzy Finder ',
    \       floatingTitlePos: 'center',
    \       filterFloatingTitle: ' Filter ',
    \       filterFloatingTitlePos: 'center',
    \       filterFloatingPosition: 'bottom',
    \       winCol: &columns / 8,
    \       winRow: &lines / 4 - 9,
    \       winWidth: (&columns - (&columns / 4)) / 2,
    \       winHeight: &lines - (&lines / 5),
    \       previewFloating: v:true,
    \       previewFloatingBorder: 'rounded',
    \       previewFloatingTitle: ' Preview ',
    \       previewFloatingTitlePos: 'center',
    \       previewCol: (&columns / 8) + (&columns - (&columns / 4)) / 2 + 2,
    \       previewRow: (&lines / 4 - 9) + (&lines - (&lines / 4)) + 5,
    \       previewWidth: (&columns - (&columns / 4)) / 2,
    \       previewHeight: &lines - (&lines / 5),
    \     }
    \   },
    \   sourceOptions: #{
    \     _: #{
    \       sorters: ['sorter_alpha'],
    \     },
    \   },
    \   filterParams: #{
    \     matcher_substring: #{
    \       highlightMatched: 'Title',
    \     },
    \     matcher_ignore_files: #{
    \       ignoreGlobs: ['.git'],
    \     },
    \   },
    \   kindOptions: #{
    \     file: #{
    \       defaultAction: 'open',
    \     },
    \   }
    \ })

call ddu#custom#patch_local('buffer', #{
    \   sourceOptions: #{
    \     buffer: #{
    \       matchers: ['matcher_substring'],
    \     },
    \   },
    \   uiParams: #{
    \     ff: #{
    \       startFilter: v:true,
    \     }
    \   }
    \ })

" brew install ripgrep が必要
call ddu#custom#patch_local('grep', #{
    \   sourceOptions: #{
    \     rg: #{
    \       matchers: ['converter_display_word', 'matcher_substring'],
    \     },
    \   },
    \   sourceParams: #{
    \     rg: #{
    \       args: ['--hidden', '--column'],
    \     },
    \   },
    \   uiParams: #{
    \     ff: #{
    \       startFilter: v:true,
    \     }
    \   }
    \ })

call ddu#custom#patch_local('file_rec', #{
    \   sourceOptions: #{
    \     file_rec: #{
    \       matchers: ['matcher_substring'],
    \     },
    \   },
    \   sourceParams: #{
    \     file_rec: #{
    \       ignoredDirectories: ['.git']
    \     },
    \   },
    \   uiParams: #{
    \     ff: #{
    \       startFilter: v:true,
    \     }
    \   }
    \ })

" ----------


" ファイルだけ下から出てくるタイプ
call ddu#custom#patch_local('filer', #{
    \   ui: 'filer',
    \   sourceOptions: #{
    \     _: #{
    \       matchers: ['matcher_ignore_files'],
    \     },
    \   },
    \   columnParams: #{},
    \ })
""{{{元の
"call ddu#custom#patch_local('filer', #{
"    \   ui: 'filer',
"    \   sourceOptions: #{
"    \     _: #{
"    \       columns: ['devicon_filename'],
"    \       matchers: ['matcher_ignore_files'],
"    \     },
"    \   },
"    \   columnParams: #{
"    \     devicon_filename: #{
"    \       indentationWidth: 2,
"    \     },
"    \   },
"    \ })
""}}}

 autocmd FileType ddu-filer call s:ddu_filer_my_settings()
 function! s:ddu_filer_my_settings() abort
   nnoremap <buffer><silent><expr> <CR>
     \ ddu#ui#get_item()->get('isTree', v:false) ?
     \ "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow'})<CR>" :
     \ "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open'})<CR>"
   nnoremap <buffer><silent><expr> o
     \ ddu#ui#get_item()->get('isTree', v:false) ?
     \ "<Cmd>call ddu#ui#do_action('expandItem', {'mode': 'toggle'})<CR>" :
     \ "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open'})<CR>"
   nnoremap <buffer><silent> s <Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<CR>
   nnoremap <buffer><silent> t <Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'tabnew'}})<CR>
   nnoremap <buffer><silent> <Space> <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
   nnoremap <buffer><silent> <Esc> <Cmd>call ddu#ui#do_action('quit')<CR>
   nnoremap <buffer><silent> q <Cmd>call ddu#ui#do_action('quit')<CR>
   nnoremap <buffer><silent> u <Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow', 'params': {'path': '..'}})<CR>
   nnoremap <buffer><silent> c <Cmd>call ddu#ui#do_action('itemAction', {'name': 'copy'})<CR>
   nnoremap <buffer><silent> p <Cmd>call ddu#ui#do_action('itemAction', {'name': 'paste'})<CR>
   nnoremap <buffer><silent> d <Cmd>call ddu#ui#do_action('itemAction', {'name': 'delete'})<CR>
   nnoremap <buffer><silent> r <Cmd>call ddu#ui#do_action('itemAction', {'name': 'rename'})<CR>
   nnoremap <buffer><silent> mv <Cmd>call ddu#ui#do_action('itemAction', {'name': 'move'})<CR>
   nnoremap <buffer><silent> nw <Cmd>call ddu#ui#do_action('itemAction', {'name': 'newFile'})<CR>
   nnoremap <buffer><silent> mk <Cmd>call ddu#ui#do_action('itemAction', {'name': 'newDirectory'})<CR>
   nnoremap <buffer><silent> yy <Cmd>call ddu#ui#do_action('itemAction', {'name': 'yank'})<CR>
 endfunction


 autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
 function! s:ddu_filter_my_settings() abort
   inoremap <buffer><silent> <CR> <Esc><Cmd>call ddu#ui#do_action('leaveFilterWindow')<CR>
   inoremap <buffer><silent> <Esc> <Esc><Cmd>call ddu#ui#do_action('quit')<CR>
 endfunction

" ----------

" autocmd TabEnter,CursorHold,FocusGained <buffer> call ddu#ui#do_action('checkItems')
