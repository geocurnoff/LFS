
namespace eval ::lfs {
  namespace export colorize

    array set ::lfs::COLOR_TABLE [list black       {[0;30m} dark-gray    {[1;30m} \
                                       red         {[0;31m} light-red    {[1;31m} \
                                       green       {[0;32m} light-green  {[1;32m} \
                                       orange      {[0;33m} yellow       {[1;33m} \
                                       blue        {[0;34m} light-blue   {[1;34m} \
                                       purple      {[0;35m} light-purple {[1;35m} \
                                       cyan        {[0;36m} light-cyan   {[1;36m} \
                                       light-gray  {[0;37m} white        {[1;37m}]  

    proc colorize {{color [0m} text} {
        set code $::lfs::COLOR_TABLE($color)
        return "\033$code$text\033\[0m"
    }
}