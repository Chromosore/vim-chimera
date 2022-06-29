# vim-chimera

vim-chimera clears the search matches (`'hlsearch'`) when you're not
searching.

I know there are several existing plugins that solve this very problem[^1],
but none of them solved this problem the way I wanted, so I've made a new
one!

I've named this plugin `vim-chimera` because then approach to choose when to
clear matches is a hybrid between the [`vim-cool`][cool] way and the
[`is.vim`][is] way.


## Installation and version

Install this plugin however you want.

It needs a decently recent version of vim to work (in other words: I have
no idea of the version requirement) and supports neovim as well.


## Hybrid approach

`vim-cool` clears matches when the cursor moves. But, to check if the move
wasn't due to a command like `n`, it also checks if the new position of the
cursor is a search match.

The downside of this approach is that it sometimes keeps matches highlighted
after you've moved, because landed on a match by accident. For instance,
this happens if you have vertically aligned matching items and you press
`j`.

`is.vim` on the other hand uses mappings to schedule autocommands that clear
the matches when the cursor is moved. For instance, when `n` is pressed, it
removes all scheduled autocommands and schedules a new one one to clear the
matches after a cursor move.

This approach is great because it is reliable (e.g. it won't keep the
matches highlighted when you don't want to) but its user-triggered model is
less great, because matches won't be removed in situations outside of the
provided mappings (such as using `:s`).

That's why I created this plugin. It uses a hybrid approach because it
relies on both autocommands and mappings. That is, it clears matches when
the cursor is moved - without checking the new position of the cursor -
unless the cursor move was initiated by one of the search commands.

---

This plugin is licensed under the `MPL-2.0`. See `LICENSE.txt`.

[^1]: is.vim, vim-cool, vim-slash, vim-evanesco

[cool]: https://github.com/romainl/vim-cool
[is]: https://github.com/haya14busa/is.vim
