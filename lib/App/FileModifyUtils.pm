package App::FileModifyUtils;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

use Exporter 'import';
our @EXPORT_OK = qw(add_line_to_file remove_line_from_file);

our %SPEC;

$SPEC{add_line_to_file} = {
    v => 1.1,
    summary => 'Add line to file',
    description => <<'_',

Uses <pm:Setup::File::Line> which supports undo, but the undo feature is not
used. See L<pm:App::FileModifyUtils::Undoable> for file-modifying CLIs which
support undo.

_
    args => {
        file => {
            schema => 'filename*',
            req => 1,
            pos => 0,
        },
        line => {
            schema => 'str*',
            req => 1,
            pos => 1,
        },
        top_style => {
            schema => 'bool*',
            cmdline_aliases => {t=>{}},
        },
    },
};
sub add_line_to_file {
    require Setup::File::Line;
    my %args = @_;
    Setup::File::Line::setup_line(
        -tx_action => 'fix_state',
        -tx_action_id => rand(),
        path => $args{file},
        line_content => $args{line},
        top_style => $args{top_style},
    );
}

$SPEC{remove_line_from_file} = {
    v => 1.1,
    summary => 'Remove all occurrences of a line from file',
    description => <<'_',

Uses <pm:Setup::File::Line> which supports undo, but the undo feature is not
used. See L<pm:App::FileModifyUtils::Undoable> for file-modifying CLIs which
support undo.

_
    args => {
        file => {
            schema => 'filename*',
            req => 1,
            pos => 0,
        },
        line => {
            schema => 'str*',
            req => 1,
            pos => 1,
        },
        case_insensitive => {
            schema => 'bool*',
        },
    },
};
sub add_line_to_file {
    require Setup::File::Line;
    my %args = @_;
    Setup::File::Line::setup_line(
        -tx_action => 'fix_state',
        -tx_action_id => rand(),
        path => $args{file},
        line_content => $args{line},
        case_insensitive => $args{top_style},
    );
}

1;
#ABSTRACT: Utilities related to modifying files

=head1 DESCRIPTION

This distribution provides the following command-line utilities:

# INSERT_EXECS_LIST


=head1 SEE ALSO

Other similar distributions: L<App::FileRenameUtils>,
L<App::FileRemoveUtilities>.

=cut
