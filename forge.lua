
local paths = {
    package.path;
    forge:root( 'lalr/?.lua' );
    forge:root( 'lalr/?/init.lua' );
};
package.path = table.concat( paths, ';' );

require 'forge';
require 'forge.lalr';
require 'forge.visual_studio';
require 'forge.xcode';
require 'forge.linux';
require 'forge.macos';
require 'forge.windows';

platform = platform or forge:operating_system();
variant = variant or 'debug';
version = version or ('%s %s %s'):format(os.date('%Y.%m.%d %H:%M:%S'), platform, variant );
goal = goal or "";
jobs = jobs or 4;

forge:initialize {
    variants = { 'debug', 'release', 'shipping' };
    bin = forge:root( ('%s/bin'):format(variant) );
    lib = forge:root( ('%s/lib'):format(variant) );
    obj = forge:root( ('%s/obj'):format(variant) );
    include_directories = {
        forge:root( 'lalr' );
        forge:root( 'unittest-cpp' );
    };
    library_directories = {
        forge:root( ('%s/lib'):format(variant) );
    };
    defines = {
        ('BUILD_PLATFORM_%s'):format( forge:upper(platform) );
        ('BUILD_VARIANT_%s'):format( forge:upper(variant) );
        ('BUILD_VERSION="\\"%s\\""'):format( version );
    };
    visual_studio = {
        sln = forge:root( 'lalr.sln' );
    };
    xcode = {
        xcodeproj = forge:root( 'lalr.xcodeproj' );
    };
    lalr = {
        lalrc = '${bin}/lalrc';
    };
};

forge:default_targets {
    'lalr/lalrc',
    'lalr/lalr_examples',
    'lalr/lalr_test'
};

buildfile 'lalr/lalr.forge';
buildfile 'unittest-cpp/unittest-cpp.forge';
