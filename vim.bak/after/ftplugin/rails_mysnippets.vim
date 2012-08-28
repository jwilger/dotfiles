if !exists('loaded_snippet') || &cp
    finish
endif

Snippet : :<{}> => '<{}>'<{}>
Snippet :: :<{}> => :<{}>
Snippet ar => <{}>

" Structure
Snippet cla class <{}><CR><{}><CR>end
Snippet def def <{}><CR><{}><CR>end

Snippet ps puts '<{}>'<CR><{}>
Snippet if if <{condition}><CR><{}><CR>end<CR>

" Attributes
Snippet r attr_reader :<{}>
Snippet w attr_writer :<{}>
Snippet rw attr_accessor :<{}>

" Testing
Snippet as assert(<{test}>, \"<{message}>\")<CR><{}>
Snippet ase assert_equal(<{expected}>, <{actual}>)<CR><{}>
Snippet asne assert_not_equal(<{unexpected}>, <{actual}>)<CR><{}>

"Rails
Snippet rc <% <{}> %>
Snippet rce <%= <{}> %><{}>

Snippet ff <% form_for :<{}>, @<{}>, :url => { :action => '<{}>' } do |f| %><CR><{}><CR><% end %>
Snippet submit <%= submit_tag '<{}>' %>


