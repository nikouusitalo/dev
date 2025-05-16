-- ~/.config/nvim/snippets/go.lua
return {
	{ trigger = "for", body = "for ${1:i} := 0; ${2:i} < ${3:n}; ${4:i}++ {\n  $0\n}" },
	{ trigger = "func", body = "func ${1:name}(${2:args}) ${3:returnType} {\n  $0\n}" },
}
