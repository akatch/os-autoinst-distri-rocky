use base "anacondatest";
use strict;
use testapi;

sub run {
    # handle bootloader screen
    assert_screen "bootloader", 30;
    # select troubleshooting
    send_key "down";
    send_key "ret";
    # select "rescue system"
    type_string "r\n";

    assert_screen "rescue_select", 120; # it takes time to start anaconda
    # continue
    type_string "1\n";
    assert_screen "rescue_enter_pass", 60; # it might take time to scan all disks
    type_string get_var("ENCRYPT_PASSWORD", "weakpassword");
    send_key "ret";
    assert_screen "rescue_mounted", 60; # it also might take time to mount disk
    send_key "ret";

    # check whether disk was mounted
    validate_script_output "mount", sub { $_ =~ m/\/mnt\/sysimage/ };
    # try to access home in chroot
    assert_script_run "chroot /mnt/sysimage ls -la /home/test";
    # try to write and read a file
    assert_script_run "chroot /mnt/sysimage /bin/bash -c 'echo Hello, world > /tmp/openqa_test'";
    validate_script_output "chroot /mnt/sysimage cat /tmp/openqa_test", sub { $_ =~ m/Hello, world/ };
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