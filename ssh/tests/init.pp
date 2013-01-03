class { 'ssh':
  port        => '22',
  private_key => true,
  site        => {
    'localhost' => {
      type => 'ssh-rsa',
      key  => 'AAAAB3NzaC1yc2EAAAABIwAAAQE45Jqnci6Hl0mMFtOtFLduHdK4L3ql/XPniqIGp9QpBK6EeupPKZU34chhmXosHoVWgouFYjzAk1NG5L176cjsvPHWnj3d8MN4SDrAt4sLwwI6T709BmRnDruGnl9c+B9iuYtvRs4V6FVjwvBCff++pAhsIu+8KXBfPTY0Fb+8u80+l0cbfB7nqtUvohPSAr2TgNDFGs+PLLBwqqZ+pPq1hlrgS9eYThAWFImKc76r+v/LyQRLP8kvaiMAEHPdVgviJAi1VyL1BNkbEXKGPBbvxFrUw+roVOaDAUDfg1WYcKkMe+JRbzXh8HZfyFewxnZiMrCNe+iXkhFS6g+BTxkhHuQ==',
    }
  }
}
