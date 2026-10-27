# Sublime Text → YASnippet

Imported from the locally installed `/opt/sublime_text/Packages/*.sublime-package` files.
156 templates across eight languages. User snippets are preserved.

Reload using `M-x yas-reload-all`. Use `M-x yas-insert-snippet` for the full list,
or type a trigger and use your configured Ctrl+Space completion. Tab moves between fields.

Both classic and tree-sitter modes inherit the relevant tables.
Sublime syntax scopes are approximated by Emacs major modes; detailed nested syntax scopes are not reproduced.
C++ include/main context and zsh-only shell snippets have explicit conditions.
Language mode packages are not installed by this import.

## Adaptations

- LaTeX `\cha`: Label default derives from heading using a lowercase underscore slug; editable separately.
- LaTeX `\par`: Label default derives from heading using a lowercase underscore slug; editable separately.
- LaTeX `\part`: Label default derives from heading using a lowercase underscore slug; editable separately.
- LaTeX `\subp`: Label default derives from heading using a lowercase underscore slug; editable separately.
- LaTeX `tab`: Use full environment name tabular/array; column contents are entered manually.
- LaTeX `\sec`: Label default derives from heading using a lowercase underscore slug; editable separately.
- LaTeX `\sub`: Label default derives from heading using a lowercase underscore slug; editable separately.
- LaTeX `\subs`: Label default derives from heading using a lowercase underscore slug; editable separately.
- Matlab `octfun`: Fixed unclosed placeholder in upstream template.
- Matlab `dsp`: disp(sprintf) uses an editable optional argument field; corrected extra closing punctuation in original.
- Matlab `func`: Output assignments are entered manually; explicit end added.
- Matlab `title`: Fixed original zla trigger collision with zlabel.
- Python `class`: Constructor arguments and attribute assignments are edited explicitly; uses Python 3 super().
- Rust `fmt`: Editable optional argument field; fmt! corrected to standard format!.
- Rust `if-let`: Fixed duplicated expression/body field number.
- Rust `panic`: Editable optional format argument field.
- Rust `print`: Editable optional format argument field.
- Rust `println`: Editable optional format argument field.
- Rust `while-let`: Fixed duplicated expression/body field number.

## Triggers

| Language | Trigger | File |
| --- | --- | --- |
| C++ | `def` | [sublime-#ifndef-#define-#endif](c++-mode/sublime-#ifndef-#define-#endif.yasnippet) |
| C++ | `Inc` | [sublime-#include-(#inc angle)](c++-mode/sublime-#include-(#inc%20angle).yasnippet) |
| C++ | `inc` | [sublime-#include-(#inc)](c++-mode/sublime-#include-(#inc).yasnippet) |
| C++ | `Inc` | [sublime-#include-(inc angle)](c++-mode/sublime-#include-(inc%20angle).yasnippet) |
| C++ | `inc` | [sublime-#include-(inc)](c++-mode/sublime-#include-(inc).yasnippet) |
| C++ | `for` | [sublime-030-for-int-loop-(fori)](c++-mode/sublime-030-for-int-loop-(fori).yasnippet) |
| C++ | `enum` | [sublime-Enumeration](c++-mode/sublime-Enumeration.yasnippet) |
| C++ | `td` | [sublime-Typedef](c++-mode/sublime-Typedef.yasnippet) |
| C++ | `class` | [sublime-class-..-(class)](c++-mode/sublime-class-..-(class).yasnippet) |
| C++ | `do` | [sublime-do...while-loop-(do)](c++-mode/sublime-do...while-loop-(do).yasnippet) |
| C++ | `forv` | [sublime-forv](c++-mode/sublime-forv.yasnippet) |
| C++ | `fprintf` | [sublime-fprintf](c++-mode/sublime-fprintf.yasnippet) |
| C++ | `if` | [sublime-if-..-(if)](c++-mode/sublime-if-..-(if).yasnippet) |
| C++ | `main` | [sublime-main()-(int main)](c++-mode/sublime-main()-(int%20main).yasnippet) |
| C++ | `main` | [sublime-main()-(main)](c++-mode/sublime-main()-(main).yasnippet) |
| C++ | `ns` | [sublime-namespace-..-(namespace)](c++-mode/sublime-namespace-..-(namespace).yasnippet) |
| C++ | `printf` | [sublime-printf-..-(printf)](c++-mode/sublime-printf-..-(printf).yasnippet) |
| C++ | `readfile` | [sublime-read-file-(readF)](c++-mode/sublime-read-file-(readF).yasnippet) |
| C++ | `map` | [sublime-std-map-(map)](c++-mode/sublime-std-map-(map).yasnippet) |
| C++ | `vector` | [sublime-std-vector-(v)](c++-mode/sublime-std-vector-(v).yasnippet) |
| C++ | `struct` | [sublime-struct](c++-mode/sublime-struct.yasnippet) |
| C++ | `tp` | [sublime-template-typename-..-(template)](c++-mode/sublime-template-typename-..-(template).yasnippet) |
| JavaScript | `get` | [sublime-Get-Elements](js-mode/sublime-Get-Elements.yasnippet) |
| JavaScript | `o:f` | [sublime-Object-Method](js-mode/sublime-Object-Method.yasnippet) |
| JavaScript | `:,` | [sublime-Object-Value-JS](js-mode/sublime-Object-Value-JS.yasnippet) |
| JavaScript | `:` | [sublime-Object-key-key-value](js-mode/sublime-Object-key-key-value.yasnippet) |
| JavaScript | `proto` | [sublime-Prototype-(proto)](js-mode/sublime-Prototype-(proto).yasnippet) |
| JavaScript | `for` | [sublime-for-()-{}-(faster)](js-mode/sublime-for-()-{}-(faster).yasnippet) |
| JavaScript | `for` | [sublime-for-()-{}](js-mode/sublime-for-()-{}.yasnippet) |
| JavaScript | `fun` | [sublime-function-(fun)](js-mode/sublime-function-(fun).yasnippet) |
| JavaScript | `f` | [sublime-function](js-mode/sublime-function.yasnippet) |
| JavaScript | `ife` | [sublime-if-else](js-mode/sublime-if-else.yasnippet) |
| JavaScript | `if` | [sublime-if](js-mode/sublime-if.yasnippet) |
| JavaScript | `timeout` | [sublime-setTimeout-function](js-mode/sublime-setTimeout-function.yasnippet) |
| LaTeX | `cas` | [sublime-Cases](latex-mode/sublime-Cases.yasnippet) |
| LaTeX | `\cha` | [sublime-Chapter](latex-mode/sublime-Chapter.yasnippet) |
| LaTeX | `desc` | [sublime-Description](latex-mode/sublime-Description.yasnippet) |
| LaTeX | `$$` | [sublime-Displaymath-($$)](latex-mode/sublime-Displaymath-($$).yasnippet) |
| LaTeX | `enum` | [sublime-Enumerate](latex-mode/sublime-Enumerate.yasnippet) |
| LaTeX | `eq` | [sublime-Equation](latex-mode/sublime-Equation.yasnippet) |
| LaTeX | `figure` | [sublime-Figure](latex-mode/sublime-Figure.yasnippet) |
| LaTeX | `itd` | [sublime-Item[description]](latex-mode/sublime-Item[description].yasnippet) |
| LaTeX | `item` | [sublime-Itemize](latex-mode/sublime-Itemize.yasnippet) |
| LaTeX | `listing` | [sublime-Listing](latex-mode/sublime-Listing.yasnippet) |
| LaTeX | `mat` | [sublime-Matrix](latex-mode/sublime-Matrix.yasnippet) |
| LaTeX | `page` | [sublime-Page](latex-mode/sublime-Page.yasnippet) |
| LaTeX | `\par` | [sublime-Paragraph](latex-mode/sublime-Paragraph.yasnippet) |
| LaTeX | `\part` | [sublime-Part](latex-mode/sublime-Part.yasnippet) |
| LaTeX | `section` | [sublime-Section](latex-mode/sublime-Section.yasnippet) |
| LaTeX | `spl` | [sublime-Split](latex-mode/sublime-Split.yasnippet) |
| LaTeX | `\subp` | [sublime-Sub-Paragraph](latex-mode/sublime-Sub-Paragraph.yasnippet) |
| LaTeX | `table` | [sublime-Table](latex-mode/sublime-Table.yasnippet) |
| LaTeX | `tab` | [sublime-Tabular](latex-mode/sublime-Tabular.yasnippet) |
| LaTeX | `\begin` | [sublime-begin{}-end{}](latex-mode/sublime-begin{}-end{}.yasnippet) |
| LaTeX | `\sec` | [sublime-section-..-(section)](latex-mode/sublime-section-..-(section).yasnippet) |
| LaTeX | `\sub` | [sublime-subsection-..-(sub)](latex-mode/sublime-subsection-..-(sub).yasnippet) |
| LaTeX | `\subs` | [sublime-subsubsection-..-(ssub)](latex-mode/sublime-subsubsection-..-(ssub).yasnippet) |
| Matlab | `octfun` | [sublime-Octave-function](matlab-mode/sublime-Octave-function.yasnippet) |
| Matlab | `^` | [sublime-^](matlab-mode/sublime-^.yasnippet) |
| Matlab | `case` | [sublime-case](matlab-mode/sublime-case.yasnippet) |
| Matlab | `clear` | [sublime-clear](matlab-mode/sublime-clear.yasnippet) |
| Matlab | `dsp` | [sublime-disp-sprintf](matlab-mode/sublime-disp-sprintf.yasnippet) |
| Matlab | `disp` | [sublime-disp](matlab-mode/sublime-disp.yasnippet) |
| Matlab | `dlmwrite` | [sublime-dlmwrite](matlab-mode/sublime-dlmwrite.yasnippet) |
| Matlab | `else` | [sublime-else](matlab-mode/sublime-else.yasnippet) |
| Matlab | `elseif` | [sublime-elseif](matlab-mode/sublime-elseif.yasnippet) |
| Matlab | `error` | [sublime-error](matlab-mode/sublime-error.yasnippet) |
| Matlab | `e` | [sublime-exp](matlab-mode/sublime-exp.yasnippet) |
| Matlab | `fpr` | [sublime-fprintf](matlab-mode/sublime-fprintf.yasnippet) |
| Matlab | `get` | [sublime-get](matlab-mode/sublime-get.yasnippet) |
| Matlab | `griddata` | [sublime-griddata](matlab-mode/sublime-griddata.yasnippet) |
| Matlab | `ifeif` | [sublime-if-elseif](matlab-mode/sublime-if-elseif.yasnippet) |
| Matlab | `line` | [sublime-line](matlab-mode/sublime-line.yasnippet) |
| Matlab | `set` | [sublime-set](matlab-mode/sublime-set.yasnippet) |
| Matlab | `func` | [sublime-small-function](matlab-mode/sublime-small-function.yasnippet) |
| Matlab | `spr` | [sublime-sprintf](matlab-mode/sublime-sprintf.yasnippet) |
| Matlab | `switch` | [sublime-switch___case___otherwise___end](matlab-mode/sublime-switch___case___otherwise___end.yasnippet) |
| Matlab | `title` | [sublime-title](matlab-mode/sublime-title.yasnippet) |
| Matlab | `uni` | [sublime-unix](matlab-mode/sublime-unix.yasnippet) |
| Matlab | `unwind` | [sublime-unwind_protect-cleanup-end](matlab-mode/sublime-unwind_protect-cleanup-end.yasnippet) |
| Matlab | `war` | [sublime-warning](matlab-mode/sublime-warning.yasnippet) |
| Matlab | `whi` | [sublime-while](matlab-mode/sublime-while.yasnippet) |
| Matlab | `xla` | [sublime-xlabel](matlab-mode/sublime-xlabel.yasnippet) |
| Matlab | `xti` | [sublime-xtick](matlab-mode/sublime-xtick.yasnippet) |
| Matlab | `yla` | [sublime-ylabel](matlab-mode/sublime-ylabel.yasnippet) |
| Matlab | `yti` | [sublime-ytick](matlab-mode/sublime-ytick.yasnippet) |
| Matlab | `zla` | [sublime-zlabel](matlab-mode/sublime-zlabel.yasnippet) |
| Lua | `fori` | [sublime-for-i-v-in-ipairs()](lua-mode/sublime-for-i-v-in-ipairs().yasnippet) |
| Lua | `for` | [sublime-for-i=1-10](lua-mode/sublime-for-i=1-10.yasnippet) |
| Lua | `forp` | [sublime-for-k-v-in-pairs()](lua-mode/sublime-for-k-v-in-pairs().yasnippet) |
| Lua | `fun` | [sublime-function-(fun)](lua-mode/sublime-function-(fun).yasnippet) |
| Lua | `function` | [sublime-function-(function)](lua-mode/sublime-function-(function).yasnippet) |
| Lua | `local` | [sublime-local-x-=-1](lua-mode/sublime-local-x-=-1.yasnippet) |
| Lua | `table.concat` | [sublime-table.concat](lua-mode/sublime-table.concat.yasnippet) |
| Lua | `table.sort` | [sublime-table.sort](lua-mode/sublime-table.sort.yasnippet) |
| Python | `class` | [sublime-New-Class](python-mode/sublime-New-Class.yasnippet) |
| Python | `property` | [sublime-New-Property](python-mode/sublime-New-Property.yasnippet) |
| Python | `try` | [sublime-Try-Except-Else-Finally](python-mode/sublime-Try-Except-Else-Finally.yasnippet) |
| Python | `try` | [sublime-Try-Except-Else](python-mode/sublime-Try-Except-Else.yasnippet) |
| Python | `try` | [sublime-Try-Except-Finally](python-mode/sublime-Try-Except-Finally.yasnippet) |
| Python | `try` | [sublime-Try-Except](python-mode/sublime-Try-Except.yasnippet) |
| Python | `__` | [sublime-__magic__](python-mode/sublime-__magic__.yasnippet) |
| Python | `for` | [sublime-for](python-mode/sublime-for.yasnippet) |
| Python | `def` | [sublime-function](python-mode/sublime-function.yasnippet) |
| Python | `ifmain` | [sublime-if-__name__-==-'__main__'](python-mode/sublime-if-__name__-==-'__main__'.yasnippet) |
| Python | `if` | [sublime-if](python-mode/sublime-if.yasnippet) |
| Python | `defs` | [sublime-method](python-mode/sublime-method.yasnippet) |
| Python | `while` | [sublime-while](python-mode/sublime-while.yasnippet) |
| Rust | `Err` | [sublime-Err](rust-mode/sublime-Err.yasnippet) |
| Rust | `Ok` | [sublime-Ok](rust-mode/sublime-Ok.yasnippet) |
| Rust | `Some` | [sublime-Some](rust-mode/sublime-Some.yasnippet) |
| Rust | `assert` | [sublime-assert](rust-mode/sublime-assert.yasnippet) |
| Rust | `assert_eq` | [sublime-assert_eq](rust-mode/sublime-assert_eq.yasnippet) |
| Rust | `bench` | [sublime-bench](rust-mode/sublime-bench.yasnippet) |
| Rust | `const` | [sublime-const](rust-mode/sublime-const.yasnippet) |
| Rust | `else` | [sublime-else](rust-mode/sublime-else.yasnippet) |
| Rust | `enum` | [sublime-enum](rust-mode/sublime-enum.yasnippet) |
| Rust | `extern-crate` | [sublime-extern-crate](rust-mode/sublime-extern-crate.yasnippet) |
| Rust | `extern-fn` | [sublime-extern-fn](rust-mode/sublime-extern-fn.yasnippet) |
| Rust | `extern-mod` | [sublime-extern-mod](rust-mode/sublime-extern-mod.yasnippet) |
| Rust | `fmt` | [sublime-fmt](rust-mode/sublime-fmt.yasnippet) |
| Rust | `fn` | [sublime-fn](rust-mode/sublime-fn.yasnippet) |
| Rust | `for` | [sublime-for](rust-mode/sublime-for.yasnippet) |
| Rust | `if-let` | [sublime-if-let](rust-mode/sublime-if-let.yasnippet) |
| Rust | `if` | [sublime-if](rust-mode/sublime-if.yasnippet) |
| Rust | `impl-trait` | [sublime-impl-trait](rust-mode/sublime-impl-trait.yasnippet) |
| Rust | `impl` | [sublime-impl](rust-mode/sublime-impl.yasnippet) |
| Rust | `let` | [sublime-let](rust-mode/sublime-let.yasnippet) |
| Rust | `loop` | [sublime-loop](rust-mode/sublime-loop.yasnippet) |
| Rust | `macro_rules` | [sublime-macro_rules](rust-mode/sublime-macro_rules.yasnippet) |
| Rust | `main` | [sublime-main](rust-mode/sublime-main.yasnippet) |
| Rust | `match` | [sublime-match](rust-mode/sublime-match.yasnippet) |
| Rust | `mod` | [sublime-mod](rust-mode/sublime-mod.yasnippet) |
| Rust | `panic` | [sublime-panic](rust-mode/sublime-panic.yasnippet) |
| Rust | `print` | [sublime-print](rust-mode/sublime-print.yasnippet) |
| Rust | `println` | [sublime-println](rust-mode/sublime-println.yasnippet) |
| Rust | `static` | [sublime-static](rust-mode/sublime-static.yasnippet) |
| Rust | `struct-tuple` | [sublime-struct-tuple](rust-mode/sublime-struct-tuple.yasnippet) |
| Rust | `struct-unit` | [sublime-struct-unit](rust-mode/sublime-struct-unit.yasnippet) |
| Rust | `struct` | [sublime-struct](rust-mode/sublime-struct.yasnippet) |
| Rust | `test` | [sublime-test](rust-mode/sublime-test.yasnippet) |
| Rust | `trait` | [sublime-trait](rust-mode/sublime-trait.yasnippet) |
| Rust | `type` | [sublime-type](rust-mode/sublime-type.yasnippet) |
| Rust | `while-let` | [sublime-while-let](rust-mode/sublime-while-let.yasnippet) |
| Rust | `while` | [sublime-while](rust-mode/sublime-while.yasnippet) |
| ShellScript | `case` | [sublime-case](sh-mode/sublime-case.yasnippet) |
| ShellScript | `elif` | [sublime-elif](sh-mode/sublime-elif.yasnippet) |
| ShellScript | `!env` | [sublime-env-shebang](sh-mode/sublime-env-shebang.yasnippet) |
| ShellScript | `forin` | [sublime-for-in](sh-mode/sublime-for-in.yasnippet) |
| ShellScript | `for` | [sublime-for](sh-mode/sublime-for.yasnippet) |
| ShellScript | `if` | [sublime-if](sh-mode/sublime-if.yasnippet) |
| ShellScript | `until` | [sublime-until](sh-mode/sublime-until.yasnippet) |
| ShellScript | `while` | [sublime-while](sh-mode/sublime-while.yasnippet) |
| ShellScript | `foreachin` | [sublime-foreach-in](sh-mode/sublime-foreach-in.yasnippet) |
| ShellScript | `foreach` | [sublime-foreach](sh-mode/sublime-foreach.yasnippet) |
| ShellScript | `repeat` | [sublime-repeat](sh-mode/sublime-repeat.yasnippet) |
