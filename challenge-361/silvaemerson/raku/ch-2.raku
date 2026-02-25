#! /usr/bin/env raku

=begin pod
https://theweeklychallenge.org/blog/perl-weekly-challenge-361/#TASK2
=end pod

# always use the latest version of Raku
use v6.*;

sub get-non-cel(@m, $candidate --> Seq) { @m.pairs.grep({ .key != $candidate }).map({ .value }); }

sub solution (@m --> Int) {
    my @candidates = @m.grep({ .sum == 0 }, :k);

    my @celebrities = @candidates.grep(-> $cand {
      get-non-cel(@m, $cand).map({ $_[$cand] }).sum == (@m.elems - 1)
    });

    return @celebrities.first if @celebrities.elems == 1;

    return -1;
} # end of sub solution (@m --> Int)

multi MAIN (:$test! ) {
    use Test;

    my @tests = [
        %{ input => (
            [0, 0, 0, 0, 1, 0],  # 0 knows 4
            [0, 0, 0, 0, 1, 0],  # 1 knows 4
            [0, 0, 0, 0, 1, 0],  # 2 knows 4
            [0, 0, 0, 0, 1, 0],  # 3 knows 4
            [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
            [0, 0, 0, 0, 1, 0],  # 5 knows 4
       ), output => 4, text => 'Example 1' },
        %{ input => (
            [0, 1, 0, 0],  # 0 knows 1
            [0, 0, 1, 0],  # 1 knows 2
            [0, 0, 0, 1],  # 2 knows 3
            [1, 0, 0, 0]   # 3 knows 0
       ), output => -1, text => 'Example 2' },
        %{ input => (
            [0, 0, 0, 0, 0],  # 0 knows NOBODY
            [1, 0, 0, 0, 0],  # 1 knows 0
            [1, 0, 0, 0, 0],  # 2 knows 0
            [1, 0, 0, 0, 0],  # 3 knows 0
            [1, 0, 0, 0, 0]   # 4 knows 0
       ), output => 0, text => 'Example 3' },
        %{ input => 
        (
            [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
            [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
            [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
            [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
            [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
            [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
       ), output => 3, text => 'Example 4' },
        %{ input => (
            [0, 1, 1, 0],  # 0 knows 1 and 2
            [1, 0, 1, 0],  # 1 knows 0 and 2
            [0, 0, 0, 0],  # 2 knows NOBODY
            [0, 0, 0, 0]   # 3 knows NOBODY
       ), output => -1, text => 'Example 5' },
        %{ input => 
        (
            [0, 0, 1, 1],  # 0 knows 2 and 3
            [1, 0, 0, 0],  # 1 knows 0
            [1, 1, 0, 1],  # 2 knows 0, 1 and 3
            [1, 1, 0, 0]   # 3 knows 0 and 1
      ), output => -1, text => 'Example 6' },
    ];

    for @tests {
        is solution( .<input> ), .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (:$test! )
