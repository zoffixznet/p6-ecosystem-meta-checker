# p6-ecosystem-meta-checker
Check Perl 6 Ecosystem modules for working links and valid JSON in META.info files

# INSTALLATION

You need Perl 5 installed and these modules installed from CPAN:

    cpan Mojo::UserAgent JSON::Meth List::UtilsBy

# USE

Simple run `perl checker.pl`

All found errors will be indicated at the end of the output:

```text
Found errors:
JSON:
https://raw.githubusercontent.com/tony-o/perl6-json-faster/master/META.info
https://raw.githubusercontent.com/zostay/P6SGI/master/META.info

404:
https://raw.githubusercontent.com/flussence/Text-Tabs-Wrap/master/META.info
https://raw.githubusercontent.com/flussence/Test-Corpus/master/META.info
https://raw.githubusercontent.com/flussence/Test-ClientServer/master/META.info
https://raw.githubusercontent.com/flussence/BufUtils/master/META.info

Unknown:
```