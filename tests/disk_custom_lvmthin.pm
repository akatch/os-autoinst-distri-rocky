use base "anacondatest";
use strict;
use testapi;

sub run {
    my $self = shift;
    # Go to INSTALLATION DESTINATION and ensure the disk is selected.
    # Because PARTITIONING starts with 'custom_', this will select custom.
    $self->select_disks();
    assert_and_click "anaconda_spoke_done";

    # Manual partitioning spoke should be displayed. Select LVM Thin
    # Partitioning scheme
    $self->custom_scheme_select("lvmthin");
    # Do 'automatic' partition creation
    assert_and_click "anaconda_part_automatic";
    assert_and_click "anaconda_spoke_done";
    assert_and_click "anaconda_part_accept_changes";

    # Anaconda hub
    assert_screen "anaconda_main_hub", 300; #

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
