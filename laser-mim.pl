#!/usr/bin/perl
# -*- cperl -*-
use 5.20.0;
use strictures 2;
use IO::Async::Stream;
use IO::Async::Loop;
use Time::HiRes 'time';

my $laser_filename = "com10:";
my $panel_filename = "com11:";

my $loop = IO::Async::Loop->new;

open my $laser_filehandle, "<+", $laser_filename or die "Can't open laser at $laser_filename: $!";
open my $panel_filehandle, "<+", $panel_filename or die "Can't open panel at $panel_filename: $!";

my $laser_stream = IO::Async::Stream->new(
					  read_handle => $laser_filehandle,
					  write_handle => $laser_filehandle,

					  on_read => sub {
					    my ($self, $bufref, $eof) = @_;
					    state $last_read_time;
					    my $this_read_time = time;
					    
					    if ($eof) {
					      die "Hmm, error or other end-of-file reading from laser?  This should not happen: $!";
					    }

					    
					  },
					 );

my $panel_stream = IO::Async::Stream->new(
					  read_handle => $panel_filehandle,
					  write_handle => $panel_filehandle,
					 );
