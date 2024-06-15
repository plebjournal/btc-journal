# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `pagy` gem.
# Please instead update this file by running `bin/tapioca gem pagy`.


# Core class
#
# source://pagy//lib/pagy.rb#7
class Pagy
  # Merge and validate the options, do some simple arithmetic and set the instance variables
  #
  # @raise [OverflowError]
  # @return [Pagy] a new instance of Pagy
  #
  # source://pagy//lib/pagy.rb#28
  def initialize(vars); end

  # Returns the value of attribute count.
  #
  # source://pagy//lib/pagy.rb#24
  def count; end

  # Returns the value of attribute from.
  #
  # source://pagy//lib/pagy.rb#24
  def from; end

  # Returns the value of attribute in.
  #
  # source://pagy//lib/pagy.rb#24
  def in; end

  # Returns the value of attribute items.
  #
  # source://pagy//lib/pagy.rb#24
  def items; end

  # Label for the current page. Allow the customization of the output (overridden by the calendar extra)
  #
  # source://pagy//lib/pagy.rb#91
  def label; end

  # Label for any page. Allow the customization of the output (overridden by the calendar extra)
  #
  # source://pagy//lib/pagy.rb#86
  def label_for(page); end

  # Returns the value of attribute last.
  #
  # source://pagy//lib/pagy.rb#24
  def last; end

  # Returns the value of attribute next.
  #
  # source://pagy//lib/pagy.rb#24
  def next; end

  # Returns the value of attribute offset.
  #
  # source://pagy//lib/pagy.rb#24
  def offset; end

  # Returns the value of attribute page.
  #
  # source://pagy//lib/pagy.rb#24
  def page; end

  # Returns the value of attribute last.
  #
  # source://pagy//lib/pagy.rb#24
  def pages; end

  # Returns the value of attribute prev.
  #
  # source://pagy//lib/pagy.rb#24
  def prev; end

  # Return the array of page numbers and :gap items e.g. [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
  #
  # source://pagy//lib/pagy.rb#44
  def series(size: T.unsafe(nil), **_); end

  # Returns the value of attribute to.
  #
  # source://pagy//lib/pagy.rb#24
  def to; end

  # Returns the value of attribute vars.
  #
  # source://pagy//lib/pagy.rb#24
  def vars; end

  protected

  # Apply defaults, cleanup blanks and set @vars
  #
  # source://pagy//lib/pagy.rb#98
  def normalize_vars(vars); end

  # Setup @items (overridden by the gearbox extra)
  #
  # source://pagy//lib/pagy.rb#111
  def setup_items_var; end

  # Setup @last (overridden by the gearbox extra)
  #
  # source://pagy//lib/pagy.rb#116
  def setup_last_var; end

  # Setup @offset based on the :gearbox_items variable
  #
  # source://pagy//lib/pagy.rb#123
  def setup_offset_var; end

  # Setup @last (overridden by the gearbox extra)
  #
  # source://pagy//lib/pagy.rb#116
  def setup_pages_var; end

  # Setup and validates the passed vars: var must be present and value.to_i must be >= to min
  #
  # source://pagy//lib/pagy.rb#103
  def setup_vars(name_min); end

  class << self
    # Gem root pathname to get the path of Pagy files stylesheets, javascripts, apps, locales, etc.
    #
    # source://pagy//lib/pagy.rb#11
    def root; end
  end
end

# Define a dummy params method if it's not already defined in the including module
#
# source://pagy//lib/pagy/backend.rb#8
module Pagy::Backend
  private

  # Return Pagy object and paginated items/results
  #
  # source://pagy//lib/pagy/backend.rb#12
  def pagy(collection, vars = T.unsafe(nil)); end

  # Get the count from the collection
  #
  # source://pagy//lib/pagy/backend.rb#27
  def pagy_get_count(collection, vars); end

  # Sub-method called only by #pagy: here for easy customization of record-extraction by overriding
  # You may need to override this method for collections without offset|limit
  #
  # source://pagy//lib/pagy/backend.rb#40
  def pagy_get_items(collection, pagy); end

  # Get the page integer from the params
  # Overridable by the jsonapi extra
  #
  # source://pagy//lib/pagy/backend.rb#34
  def pagy_get_page(vars); end

  # Sub-method called only by #pagy: here for easy customization of variables by overriding
  # You may need to override the count call for non AR collections
  #
  # source://pagy//lib/pagy/backend.rb#19
  def pagy_get_vars(collection, vars); end
end

# Core defult: constant for easy access, but mutable for customizable defaults
#
# source://pagy//lib/pagy.rb#16
Pagy::DEFAULT = T.let(T.unsafe(nil), Hash)

# Frontend modules are specially optimized for performance.
# The resulting code may not look very elegant, but produces the best benchmarks
#
# source://pagy//lib/pagy/frontend.rb#14
module Pagy::Frontend
  include ::Pagy::UrlHelpers

  # Return a performance optimized lambda to generate the HtML anchor element (a tag)
  # Benchmarked on a 20 link nav: it is ~22x faster and uses ~18x less memory than rails' link_to
  #
  # source://pagy//lib/pagy/frontend.rb#56
  def pagy_anchor(pagy); end

  # Return examples: "Displaying items 41-60 of 324 in total" or "Displaying Products 41-60 of 324 in total"
  #
  # source://pagy//lib/pagy/frontend.rb#40
  def pagy_info(pagy, id: T.unsafe(nil), item_name: T.unsafe(nil)); end

  # Generic pagination: it returns the html with the series of links to the pages
  #
  # source://pagy//lib/pagy/frontend.rb#18
  def pagy_nav(pagy, id: T.unsafe(nil), aria_label: T.unsafe(nil), **vars); end

  # Similar to I18n.t: just ~18x faster using ~10x less memory
  # (@pagy_locale explicitly initialized in order to avoid warning)
  #
  # source://pagy//lib/pagy/frontend.rb#70
  def pagy_t(key, opts = T.unsafe(nil)); end

  private

  # source://pagy//lib/pagy/frontend.rb#76
  def nav_aria_label(pagy, aria_label: T.unsafe(nil)); end

  # source://pagy//lib/pagy/frontend.rb#89
  def next_a(pagy, a, text: T.unsafe(nil), aria_label: T.unsafe(nil)); end

  # source://pagy//lib/pagy/frontend.rb#81
  def prev_a(pagy, a, text: T.unsafe(nil), aria_label: T.unsafe(nil)); end
end

# Pagy i18n implementation, compatible with the I18n gem, just a lot faster and lighter
#
# source://pagy//lib/pagy/i18n.rb#8
module Pagy::I18n
  extend ::Pagy::I18n

  # Public method to configure the locales: overrides the default, build the DATA and freezes it
  #
  # source://pagy//lib/pagy/i18n.rb#150
  def load(*locales); end

  # Translate and pluralize the key with the locale DATA
  #
  # source://pagy//lib/pagy/i18n.rb#157
  def t(locale, key, opts = T.unsafe(nil)); end

  # Translate and pluralize the key with the locale DATA
  #
  # source://pagy//lib/pagy/i18n.rb#157
  def translate(locale, key, opts = T.unsafe(nil)); end

  private

  # Build the DATA hash out of the passed locales
  #
  # source://pagy//lib/pagy/i18n.rb#133
  def build(*locales); end

  # Create a flat hash with dotted notation keys
  #
  # source://pagy//lib/pagy/i18n.rb#126
  def flatten(initial, prefix = T.unsafe(nil)); end
end

# Stores the i18n DATA structure for each loaded locale
# default on the first locale DATA
#
# source://pagy//lib/pagy/i18n.rb#121
Pagy::I18n::DATA = T.let(T.unsafe(nil), Hash)

# Pluralization rules
#
# source://pagy//lib/pagy/i18n.rb#12
module Pagy::I18n::P11n; end

# Store the RULE to apply to each LOCALE
# the :one_other RULE is the default for locales missing from this list
#
# source://pagy//lib/pagy/i18n.rb#95
Pagy::I18n::P11n::LOCALE = T.let(T.unsafe(nil), Hash)

# Store the proc defining each pluralization RULE
# Logic adapted from https://github.com/svenfuchs/rails-i18n
#
# source://pagy//lib/pagy/i18n.rb#26
Pagy::I18n::P11n::RULE = T.let(T.unsafe(nil), Hash)

# I18n configuration error
#
# source://pagy//lib/pagy/exceptions.rb#21
class Pagy::I18nError < ::StandardError; end

# Generic internal error
#
# source://pagy//lib/pagy/exceptions.rb#24
class Pagy::InternalError < ::StandardError; end

# source://pagy//lib/pagy/frontend.rb#10
Pagy::LABEL_TOKEN = T.let(T.unsafe(nil), String)

# Specific overflow error
#
# source://pagy//lib/pagy/exceptions.rb#18
class Pagy::OverflowError < ::Pagy::VariableError; end

# Used for search and replace, hardcoded also in the pagy.js file
#
# source://pagy//lib/pagy/frontend.rb#9
Pagy::PAGE_TOKEN = T.let(T.unsafe(nil), String)

# Provide the helpers to handle the url in frontend and backend
#
# source://pagy//lib/pagy/url_helpers.rb#5
module Pagy::UrlHelpers
  # Add the page and items params
  # Overridable by the jsonapi extra
  #
  # source://pagy//lib/pagy/url_helpers.rb#21
  def pagy_set_query_params(page, vars, query_params); end

  # Return the URL for the page, relying on the params method and Rack by default.
  # It supports all Rack-based frameworks (Sinatra, Padrino, Rails, ...).
  # For non-rack environments you can use the standalone extra
  #
  # source://pagy//lib/pagy/url_helpers.rb#9
  def pagy_url_for(pagy, page, absolute: T.unsafe(nil), **_); end
end

# source://pagy//lib/pagy.rb#8
Pagy::VERSION = T.let(T.unsafe(nil), String)

# Generic variable error
#
# source://pagy//lib/pagy/exceptions.rb#5
class Pagy::VariableError < ::ArgumentError
  # Set the variables and prepare the message
  #
  # @return [VariableError] a new instance of VariableError
  #
  # source://pagy//lib/pagy/exceptions.rb#9
  def initialize(pagy, variable, description, value); end

  # Returns the value of attribute pagy.
  #
  # source://pagy//lib/pagy/exceptions.rb#6
  def pagy; end

  # Returns the value of attribute value.
  #
  # source://pagy//lib/pagy/exceptions.rb#6
  def value; end

  # Returns the value of attribute variable.
  #
  # source://pagy//lib/pagy/exceptions.rb#6
  def variable; end
end
