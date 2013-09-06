module Xcodeproj
  class Project
    module Object

      # Encapsulates the information a specific build configuration referenced
      # by a {XCConfigurationList} which in turn might be referenced by a
      # {PBXProject} or a {PBXNativeTarget}.
      #
      class XCBuildConfiguration < AbstractObject

        # @!group Attributes

        # @return [String] the name of the Target.
        #
        attribute :name, String

        # @return [Hash] the build settings to use for building the target.
        #
        attribute :build_settings, Hash, {}

        # @return [PBXFileReference] an optional file reference to a
        #         configuration file (`.xcconfig`).
        #
        has_one :base_configuration_reference, PBXFileReference

        #---------------------------------------------------------------------#

        public

        # @!group AbstractObject Hooks

        # @return [Hash{String => Hash}] A hash suitable to display the object
        #         to the user.
        #
        def pretty_print
          data = {}
          data['Build Settings'] = build_settings
          if base_configuration_reference
            data['Base Configuration'] = base_configuration_reference.pretty_print
          end
          { name => data }
        end

        #---------------------------------------------------------------------#

        def duplicate
          duplicate = super
          product_name = duplicate.build_settings["PRODUCT_NAME"]
          duplicate.build_settings["PRODUCT_NAME"] = product_name + " duplicate"
          duplicate
        end
      end
    end
  end
end
