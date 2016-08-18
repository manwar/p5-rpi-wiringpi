#!/usr/bin/perl
use warnings;
use strict;

use RPi::WiringPi;
use RPi::WiringPi::Constant qw(:all);
use Time::HiRes qw(usleep);

if (! @ARGV){
    print "\nneed test number as arg: 1-WPI, 2-GPIO, 3-PHYS, 4-SYS\n";
    print "\nthis test tests the pwm() pin function. " .
          "Connect an LED to physical pin *12*\n";
    exit;
}

# phys 12, wpi 1, gpio 18

# LED should gradually get brighter then turn off for all tests

if (! @ARGV){
    print "need arg\n";
    exit;
}

my $which = $ARGV[0];

my $mod = 'RPi::WiringPi';

# wpi

if ($which == 1){ 
    print "WPI scheme test\n";

    die "\ntest 1 requires root\n" if $> != 0;

    my $pi = $mod->new;
    my $p = $pi->pin(1);
    
    $p->mode(PWM_OUT);

    for (0..100){
        $p->pwm($_);
        usleep 5000;
    }
    print "hit ENTER...\n";
    <STDIN>;

    $p->pwm(0);
    $p->mode(INPUT);
    $p->write(LOW);
}

# gpio

if ($which == 2){ 
    print "GPIO scheme test\n";

    die "\ntest 2 requires root\n" if $> != 0;

    my $pi = $mod->new(setup => 'gpio');
    my $p = $pi->pin(18);
    
    $p->mode(PWM_OUT);

    for (0..100){
        $p->pwm($_);
        usleep 5000;
    }
    print "hit ENTER...\n";
    <STDIN>;

    $p->pwm(0);
    $p->mode(INPUT);
    $p->write(LOW);
}

# phys

if ($which == 3){ 
    print "PHYS scheme test\n";

    die "\ntest 3 requires root\n" if $> != 0;

    my $pi = $mod->new(setup => 'phys');
    my $p = $pi->pin(12);
    
    $p->mode(PWM_OUT);

    for (0..100){
        $p->pwm($_);
        usleep 5000;
    }
    print "hit ENTER...\n";
    <STDIN>;

    $p->pwm(0);
    $p->mode(INPUT);
    $p->write(LOW);
}

# sys

if ($which == 4){
    print "GPIO_SYS scheme test\n";

    die "\ntest 4 requires a non-root user\n" if $> == 0;

    my $pi = $mod->new(setup => 'sys');
    my $p = $pi->pin(18);

    $p->mode(PWM_OUT);

    for (0..100){
        $p->pwm($_);
        usleep 5000;
    }
    print "hit ENTER...\n";
    <STDIN>;

    $p->pwm(0);
    $p->mode(INPUT);
    $p->write(LOW);
}