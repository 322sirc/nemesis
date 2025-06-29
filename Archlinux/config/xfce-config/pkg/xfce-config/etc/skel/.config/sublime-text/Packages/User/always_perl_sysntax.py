import sublime
import sublime_plugin

class AlwaysUsePerlSyntaxListener(sublime_plugin.EventListener):
    def on_load(self, view):
        view.set_syntax_file('Packages/Perl/Perl.sublime-syntax')

    def on_new(self, view):
        view.set_syntax_file('Packages/Perl/Perl.sublime-syntax')
