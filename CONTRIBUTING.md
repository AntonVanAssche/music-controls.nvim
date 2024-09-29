# Contributing

All contributions are welcome! Just open a pull request.

You can start by fixing [issues](https://github.com/AntonVanAssche/music-controls.nvim/issues)
labeled with [good first issue](https://github.com/AntonVanAssche/music-controls.nvim/labels/good%20first%20issue).

## Coding Style

- Follow the coding style of [LuaRocks](https://github.com/luarocks/lua-style-guide).
- Make sure you format the code with [StyLua](https://github.com/JohnnyMorganz/StyLua)
  before opening a PR.

## Git Commits

Properly structured commits help other people review your changes, understand
why you make the change and they help in keeping the history clean, making it
easier to search using familiar tools such as `git log`.

### The Code

A commit is an atomic (explained below) change to the code base, changes made in
a commit can depend on changes made in earlier commits, but **never** on changes
in later commits.

Having atomic commits means that a commit does one thing, and one thing only.
If, for example, you fix a bug, and then also fix some _unrelated_ comment,
those should be two separate commits. It also means that a single commit should
encompass a whole change, if you are moving a piece of code from one file to the
other, this should be a single commit. Don't split this into two commits where one
adds it and the other removes it.

### The commit message

Commit messages are not something where you enter random text, they are there to
help others (and yourself) to understand **why** a change was made, as well as
any particulars someone (like a reviewer) should be aware of.

A commit message is composed of the following elements:

#### Message title

A commit message starts with a title, it serves a similar purpose to the title
of a newspaper article, it tells the reader what the article is about.

A title consists of:

- A single, short sentence telling people what changes.
- Optionally, you can add a tag or annotation at the start of the title,
  written between `[ ]`, to categorize the commit.
  - For example: `[docs]` when altering the Vim help file, or `[cmd]` When adding
    a new command.

Guidelines for a good title:

- No longer than 50 characters.
- Written in the imperative form.
- Start with a capital letter like any normal sentence.
- Omit punctuation at the end of the title.
- The tag or annotation should be all lowercase.

#### Message body

The body of a commit message is optional, although highly recommended. When a
commit is a bit larger than a single line, it really becomes mandatory.
The body is separated from the title by an empty line.

Guidelines for a good body:

- Keep line at 72 characters maximum.
- Include an in-depth explanation of **why** you make this change.
- Include an in-depth explanation of **what** you want to achieve.
- If the change is a bit more complex, add an explanation on **how** you
  changed it.
- Include punctuation.

Make sure your commit message is not only readable in a web browser when viewing
on GitHub, but also when viewed from the command line.

### References

The following articles provide some good guidelines, these form the basis of our
own guidelines and can be an interesting read if you want to know more.

- [1] <http://www.philandstuff.com/2014/02/09/git-pickaxe.html>
- [2] <https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html>
- [3] <https://www.danijelavrzan.com/posts/2023/02/create-pull-request/>
- [4] <https://dev.to/karaluton/a-guide-to-perfecting-pull-requests-2b66>
- [5] <https://commit.style/>
