## Role Directory Structure

An Ansible role has a defined directory structure with seven main standard directories. You must include at least one of these directories in each role. You can omit any directories the role does not use. For example:

    # playbooks
    site.yml
    webservers.yml
    fooservers.yml

    roles/
    common/               # this hierarchy represents a "role"
        tasks/            #
            main.yml      #  <-- tasks file can include smaller files if warranted
        handlers/         #
            main.yml      #  <-- handlers file
        templates/        #  <-- files for use with the template resource
            ntp.conf.j2   #  <------- templates end in .j2
        files/            #
            bar.txt       #  <-- files for use with the copy resource
            foo.sh        #  <-- script files for use with the script resource
        vars/             #
            main.yml      #  <-- variables associated with this role
        defaults/         #
            main.yml      #  <-- default lower priority variables for this role
        meta/             #
            main.yml      #  <-- role dependencies
        library/          # roles can also include custom modules
        module_utils/     # roles can also include custom module_utils
        lookup_plugins/   # or other types of plugins, like lookup in this case

    webtier/              # same kind of structure as "common" was above, done for the webtier role
    monitoring/           # ""
    fooapp/               # ""

By default, Ansible will look in most role directories for a main.yml file for relevant content (also main.yaml and main):

- tasks/main.yml - A list of tasks that the role provides to the play for execution.

- handlers/main.yml - handlers that are imported into the parent play for use by the role or other roles and tasks in the play.

- defaults/main.yml - very low precedence values for variables provided by the role (see Using variables for more information). A role’s own defaults will take priority over other role’s defaults, but any/all other variable sources will override this.

- vars/main.yml - high precedence variables provided by the role to the play (see Using variables for more information).

- files/stuff.txt - one or more files that are available for the role and it’s children.

- templates/something.j2 - templates to use in the role or child roles.

- meta/main.yml - metadata for the role, including role dependencies and optional Galaxy metadata such as platforms supported. This is required for uploading into galaxy as a standalone role, but not for using the role in your play.
