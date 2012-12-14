==================
Sudo Puppet module
==================

The definition `sudo::directive` provides a simple way to write sudo
configurations parts.

------------------
Use
------------------

`directive`s are blocks of literal text as you would write to sudoers.

If you have a class of users named `users::virtual` and a virtual Group named
`admin`:

::

  class example {
    include sudo
    include users::virtual

    realize(Group['admin'])

    sudo::directive {'admin_users':
      ensure  => present,
      content => "%admin ALL=(ALL) ALL",
      require => Group['admin'],
    }
  }

