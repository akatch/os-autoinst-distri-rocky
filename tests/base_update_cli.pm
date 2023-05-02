use base "installedtest";
use strict;
use testapi;
use packagetest;

sub run {
    my $self = shift;
    # switch to TTY3 for both, graphical and console tests
    $self->root_console(tty => 3);
    # enable test repos and install test packages
    prepare_test_packages;
    # check rpm agrees they installed good
    verify_installed_packages;
    if (get_var("DISTRI") eq "rocky") {
        # pandoc-common is in PowerTools in RockyLinux
        assert_script_run 'dnf config-manager --set-enabled powertools', 60;
    }
    # update the fake pandoc-common (should come from the real repo)
    # this can take a long time if we get unlucky with the metadata refresh
    assert_script_run 'dnf -y --disablerepo=openqa-testrepo* --disablerepo=updates-testing update pandoc-common', 600;
    # check we got the updated version
    verify_updated_packages;
    # now remove pandoc-common, and see if we can do a straight
    # install from the default repos
    assert_script_run 'dnf -y remove pandoc-common';
    assert_script_run 'dnf -y --disablerepo=openqa-testrepo* --disablerepo=updates-testing install pandoc-common', 120;
    assert_script_run 'rpm -V pandoc-common';
}

sub test_flags {
    return {fatal => 1};
}

1;

# vim: set sw=4 et:
