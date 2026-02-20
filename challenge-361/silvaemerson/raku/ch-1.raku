#! /usr/bin/env raku

=begin pod
https://theweeklychallenge.org/blog/perl-weekly-challenge-361/#TASK1
=end pod

# always use the latest version of Raku
use v6.*;

sub gen-fib(Int $n) {
  my @arr = 1, 2;

  while @arr.tail(2).sum <= $n { @arr.append(@arr.tail(2).sum) };

  return @arr
}

sub solution (Int $n) {
  my @fib-seq = gen-fib($n);

  return ($n) if @fib-seq.tail == $n;

  my $cursor = 1;
  my @zeckendorf-seq = (@fib-seq[*-$cursor]);

  while @zeckendorf-seq.sum < $n {
    $cursor += 1;

    my $last-idx = @fib-seq.first(@zeckendorf-seq.tail, :k);
    my $is-leq-n = (@fib-seq[*-$cursor] + @zeckendorf-seq.sum) <= $n;
    my $is-non-consecutive = ($last-idx - (@fib-seq.elems - $cursor)).abs > 1;

    @zeckendorf-seq.append(@fib-seq[*-$cursor]) if $is-leq-n and $is-non-consecutive;
  }

  return @zeckendorf-seq;
} # end of sub solution ()

multi MAIN (:$test! ) {
    use Test;

    my @tests = [
        %{ input => 4, output => (3, 1), text => 'Example 1' },
        %{ input => 12, output => (8, 3, 1), text => 'Example 2' },
        %{ input => 20, output => (13, 5, 2), text => 'Example 3' },
        %{ input => 96, output => (89,5,2), text => 'Example 4' },
        %{ input => 100, output => (89,8,3), text => 'Example 5' },
    ];

    for @tests {
        is solution( .<input> ), .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (:$test! )
