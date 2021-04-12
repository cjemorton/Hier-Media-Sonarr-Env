use 5.006;
use strict;
use warnings;
use JSON::PP;
use JSON::Parse 'json_file_to_perl';

# USEAGE EXAMPLE
# perl get_settings.pl /usr/local/etc/heir_media_sonarr_settings.json
# NOTE: This location can be any place on the filesystem that is readable.

sub note() {
	return "The settings file does not exist, lets create it. Input validation has not yet been implemented. \n"
}
sub get_apikey() {
	print "Enter API Key for Sonarr.: ";
        my $S_APIKEY = <STDIN>;
        $S_APIKEY =~ s/[\n\r\f\t]//g;
	return $S_APIKEY
}
sub get_ip() {
        print "Enter the IP address for Sonarr.: ";
        my $S_IP = <STDIN>;
        $S_IP =~ s/[\n\r\f\t]//g;
        return $S_IP
}
sub get_port() {
        print "Enter the Port Sonarr is running on.: ";
        my $S_IP = <STDIN>;
        $S_IP =~ s/[\n\r\f\t]//g;
        return $S_IP
}
sub get_dir_fast() {
        print "Fast storage, symbolic links directory.: ";
        my $S_IP = <STDIN>;
        $S_IP =~ s/[\n\r\f\t]//g;
        return $S_IP
}
sub get_dir_general() {
        print "General storage, symbolic links directory.: ";
        my $S_IP = <STDIN>;
        $S_IP =~ s/[\n\r\f\t]//g;
        return $S_IP
}
sub get_dir_archive() {
        print "Archive storage, symbolic links directory.: ";
        my $S_IP = <STDIN>;
        $S_IP =~ s/[\n\r\f\t]//g;
        return $S_IP
}

# Open Settings.
#my $settings_filename = 'settings.json';





my ($settings_filename) = @ARGV;

if (not defined $settings_filename) {
        die "USEAGE: Missing settings filename.\n";
}










if (! -e $settings_filename) {
	print note();
	$ENV{S_APIKEY} = get_apikey();
	$ENV{S_IP} = get_ip();
	$ENV{S_PORT} = get_port();
	$ENV{S_DIR_FAST} = get_dir_fast();
	$ENV{S_DIR_GEN} = get_dir_general();
	$ENV{S_DIR_ARC} = get_dir_archive();

# Convert settings to json and write it to file.
	my %settings_hash = ('S_APIKEY' => "$ENV{S_APIKEY}", 
	'S_IP' => "$ENV{S_IP}", 
	'S_PORT' => "$ENV{S_PORT}", 
	'S_DIR_FAST' => "$ENV{S_DIR_FAST}",
	'S_DIR_GEN' => "$ENV{S_DIR_GEN}",
	'S_DIR_ARC' => "$ENV{S_DIR_ARC}"
	);

	my $json = JSON::PP->new->utf8->encode(\%settings_hash);
	open(FH, '>', $settings_filename) or die $!;
	print FH $json;
	close(FH);
}

# Move settings in JSON file into perl hash.
my $settings_string_from_file = json_file_to_perl ($settings_filename);
my %settings_hash = %$settings_string_from_file;

# Set each element in perl hash to environment variables.

$ENV{S_APIKEY} = "$settings_hash{'S_APIKEY'}";
$ENV{S_IP} = "$settings_hash{'S_IP'}";
$ENV{S_PORT} = "$settings_hash{'S_PORT'}";
$ENV{S_DIR_FAST} = "$settings_hash{'S_DIR_FAST'}";
$ENV{S_DIR_GEN} = "$settings_hash{'S_DIR_GEN'}";
$ENV{S_DIR_ARC} = "$settings_hash{'S_DIR_ARC'}";

#print "$s{'S_IP'}\n";

# Check settings.
#foreach (sort keys %ENV) { 
#  print "$_  =  $ENV{$_}\n"; 
#}
