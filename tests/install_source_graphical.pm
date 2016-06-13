use base "anacondatest";
use strict;
use testapi;

sub run {
    my $self = shift;
    # Anaconda hub
    assert_screen "anaconda_main_hub", 300; #

    # Go into the Install Source spoke
    assert_and_click "anaconda_main_hub_installation_source";

    # select appropriate protocol on the network
    assert_and_click "anaconda_install_source_on_the_network";
    send_key "tab";
    # if we have an NFS repo select NFS (one 'up'), otherwise HTTP (four 'ups')
    my $num;
    $num = get_var("REPOSITORY_GRAPHICAL") =~ m/^nfs:/ ? 1 : 4;
    for (my $i=0; $i<$num; $i++){
        send_key "up";
    }
    # let's just accept either NFS or HTTP here, if it's the wrong one the
    # test will fail soon anyhow
    assert_screen "anaconda_install_source_selected";


    # insert the url
    send_key "tab";
    my $repourl = "";

    # if either MIRRORLIST_GRAPHICAL or REPOSITORY_GRAPHICAL is set, type this into
    # the repository url input
    if (get_var("MIRRORLIST_GRAPHICAL")) {
        $repourl = $self->get_mirrorlist_url();
        type_string $repourl;

        # select as mirror list
        assert_and_click "anaconda_install_source_repo_select_mirrorlist";
    }
    elsif (get_var("REPOSITORY_GRAPHICAL")) {
        $repourl = $self->get_full_repo(get_var("REPOSITORY_GRAPHICAL"));
        # strip the 'nfs:' for typing here
        $repourl =~ s/^nfs://;
        type_string $repourl;
    }

    assert_and_click "anaconda_spoke_done";

    # Anaconda hub
    assert_screen "anaconda_main_hub", 300;
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
