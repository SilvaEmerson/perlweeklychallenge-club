#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 

=SUBTITLE
=head2 Submitted by

=CHALLENGE
=head2

=head3 Example 1:

=head3 Example 2:

=head3 Example 3:

=head3 Example 4:

=head3 Example 5:

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub my-sub (Str $input --> Str) {
  $input.comb ==> pairs()
              ==> map({ .value x (.key + 1) })
              ==> join('')
} # end of sub my-sub ()

multi MAIN (:$test! ) {
    use Test;

    my @tests = [
        %{ input => "abca", output => "abbcccaaaa", text => 'Example 1' },
        %{ input => "xyz", output => "xyyzzz", text => 'Example 2' },
        %{ input => "code", output => "coodddeeee", text => 'Example 3' },
        %{ input => "hello", output => "heelllllllooooo", text => 'Example 4' },
        %{ input => "a", output => "a", text => 'Example 5' },
    ];

    for @tests {
        is my-sub( .<input> ), .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (:$test! )

