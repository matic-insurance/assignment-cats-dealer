module Cats
  class Find
    include Interactor::Organizer

    organize Cats::Fetch, Cats::Filter
  end
end
