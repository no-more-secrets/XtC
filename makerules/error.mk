#####################################################################
# Error handling functions

assertEqual = $(call assert,$(call seq,$1,$2),$3)

# This is the error given to the user if make attempts to use a rule
# in a makefile in one folder to build a target in another folder
# which indicates that the wrong rule was selected.  This can happen
# as a result of make's process for deciding which rule to use for
# a given target when there are multiple possible matches, coupled
# with the dependency structure of the program, the order in which
# make files are read in, and make's attempt to build prerequisites
# of targets which may reside in other folders (it has a global view
# of all dependencies).
location_error = $(warning error: $@ [in the "$(target_path)" folder] \
    cannot be built by a rule in the "$(targetCWD_path)" folder!)@false
# Check for and report the location_error described above
assert_target_location = $($(call ifseq,$(targetCWD_path),$(target_path),,location_error))
