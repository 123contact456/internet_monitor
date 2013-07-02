require 'spec_helper'

describe 'countries requests' do
  subject { page }

  describe 'get /countries' do
    before {
      visit( countries_url )
    }

    it {
      should( have_selector( "title", { text: "countries @ Internet Monitor" } ) )
    }
  end

  shared_examples_for( 'category_selector' ) {
    it ( 'should have category selector links' ) {
      should have_selector( ".category-selector a[href*='#{access_path( country )}']" );
      should have_selector( ".category-selector a[href*='#{control_path( country )}']" );
      should have_selector( ".category-selector a[href*='#{activity_path( country )}']" );
    }
  }


  describe( "get /countries/:id" ) do
    let ( :country ) { Country.find_by_iso3_code( 'IRN' ) }

    before { visit country_url( country ) }

    it {
      should( have_selector( "title", { text: "#{country.name.downcase} @ Internet Monitor" } ) )
    }

    it {
      should( have_selector( "h1 a", { text: "#{country.name} ( #{country.score.round(2)} )" } ) )
    }

    it_should_behave_like( 'category_selector' );
  end

  describe( "get /countries/:id/access" ) do
    let ( :country ) { Country.find_by_iso3_code( 'IRN' ) }

    before {
      visit access_url( country )
    }

    it {
      should( have_selector( "title", { text: "#{country.name.downcase} access @ Internet Monitor" } ) )
    }

    it_should_behave_like( 'category_selector' );
  end

  describe( "get /countries/:id/control" ) do
    let ( :country ) { Country.find_by_iso3_code( 'IRN' ) }

    before {
      visit control_url( country )
    }

    it {
      should( have_selector( "title", { text: "#{country.name.downcase} control @ Internet Monitor" } ) )
    }

    it_should_behave_like( 'category_selector' );
  end

  describe( "get /countries/:id/activity" ) do
    let ( :country ) { Country.find_by_iso3_code( 'IRN' ) }

    before {
      visit activity_url( country )
    }

    it {
      should( have_selector( "title", { text: "#{country.name.downcase} activity @ Internet Monitor" } ) )
    }

    it_should_behave_like( 'category_selector' );
  end
end