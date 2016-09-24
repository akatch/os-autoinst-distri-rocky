use base "installedtest";
use strict;
use testapi;

sub run {
    my $self = shift;
    # decrypt disks during boot if necessary
    if (get_var("ENCRYPT_PASSWORD")) {
        $self->boot_decrypt(60);
    }

    # wait for either graphical or text login
    if (get_var('DESKTOP')) {
        $self->boot_to_login_screen("graphical_login", 45, 120); # DM takes time to load
    } else {
        $self->boot_to_login_screen();
    }
    # switch to TTY3 for both, graphical and console tests
    $self->root_console(tty=>3);
    # disable screen blanking (update can take a long time)
    script_run "setterm -blank 0";

    # upgrader should be installed on up-to-date system

    assert_script_run 'dnf -y update', 1800;

    script_run "reboot";

    # decrypt if necessary
    if (get_var("ENCRYPT_PASSWORD")) {
        $self->boot_decrypt(60);
    }

    if (get_var('DESKTOP')) {
        $self->boot_to_login_screen("graphical_login", 45, 120); # DM takes time to load
    } else {
        $self->boot_to_login_screen();
    }
    $self->root_console(tty=>3);

    my $update_command = 'dnf -y install dnf-plugin-system-upgrade';
    assert_script_run $update_command, 600;
}


sub test_flags {
    # without anything - rollback to 'lastgood' snapshot if failed
    # 'fatal' - whole test suite is in danger if this fails
    # 'milestone' - after this test succeeds, update 'lastgood'
    # 'important' - if this fails, set the overall state to 'fail'
    return { fatal => 1 };
}

1;

# vim: set sw=4 et:
