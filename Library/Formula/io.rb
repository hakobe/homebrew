require 'formula'

class Io < Formula
  head 'https://github.com/stevedekorte/io.git', :tag => '3b3b9f6faebfa964aa43b04bef8ee20b0f94a85a'
  homepage 'http://iolanguage.com/'

  depends_on 'cmake' => :build
  depends_on 'libsgml'
  depends_on 'ossp-uuid'
  depends_on 'libevent'

  # Either CMake doesn't detect OS X's png include path correctly,
  # or there's an issue with io's build system; force the path in
  # so we can build.
  def patches
    DATA
  end

  def install
    ENV.j1
    mkdir 'io-build'

    Dir.chdir 'io-build' do
      system "cmake .. #{std_cmake_parameters}"
      system "make install"
    end

    rm_f Dir['docs/*.pdf']
    doc.install Dir['docs/*']

    prefix.install 'license/bsd_license.txt' => 'LICENSE'
  end
end

__END__
diff --git a/libs/basekit/source/Common_inline.h b/libs/basekit/source/Common_inline.h
index 0f3680e..9dbd077 100755
--- a/libs/basekit/source/Common_inline.h
+++ b/libs/basekit/source/Common_inline.h
@@ -52,16 +52,17 @@ Kudos to Daniel A. Koepke
 
 #if defined(__APPLE__) 
 
-	#define NS_INLINE static __inline__ __attribute__((always_inline))
+	// #define NS_INLINE static __inline__ __attribute__((always_inline))
+	#define IO_NS_INLINE static inline
 
 	#ifdef IO_IN_C_FILE
 		// in .c 
 		#define IO_DECLARE_INLINES
-		#define IOINLINE NS_INLINE
+		#define IOINLINE IO_NS_INLINE
 	#else
 		// in .h 
 		#define IO_DECLARE_INLINES
-		#define IOINLINE NS_INLINE
+		#define IOINLINE IO_NS_INLINE
 	#endif 	
 
 /*		
