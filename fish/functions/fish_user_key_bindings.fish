function fish_user_key_bindings
	for mode in insert default visual
        	bind -M $mode \cX forward-char
    	end
	for mode in insert default visual
        	bind -M $mode \cF forward-char
    	end
end
