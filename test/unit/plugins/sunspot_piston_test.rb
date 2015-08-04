require 'test_helper'


class SunspotPistonTest < ActiveSupport::TestCase
  def setup
    @admin = admins(:wheel)
    @admin.index!
  end

  def test_indexer_fires
    search = Admin.search{ fulltext "wheel" }
    assert_not_empty search.results, "there's no results to start with"

    @admin.update_attributes name: "OMGLOL"

    sleep(1)

    search = Admin.search{ fulltext "OMGLOL" }.results
    assert_not_empty search
  end

  def test_indexer_does_not_fire_for_unmapped_objects
    admin_traits(:wheels_something_else).update_attributes value: "whatever"
    assert_not_equal "admin_traits", $last_reindexed
  end

end