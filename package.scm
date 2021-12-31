(use-modules (guix packages)
	(guix gexp)
	((guix licenses) #:prefix license:)
	(guix download)
	(guix git-download)
	(guix build-system meson)
	(gnu packages pkg-config)
	(gnu packages cmake)
	(gnu packages boost)
	(gnu packages cpp)
	(gnu packages tls)
	(gnu packages certs)
	(gnu packages commencement)
	(gnu packages pretty-print)
	(gnu packages llvm))

;in order for discordpp to be able to have endpoints with vectors in them, it needs to be able to use fmt/ranges.h so it doesn't error on a std::vector<Snowflake>,
;but that isn't supported in 8.0.1 and there is no 8.0.2 yet. So, I'm just going to make it depend on the current commit(as of writing) that's in the repo
;and leave it at that for now. Once there is a 8.0.2 this can be changed. Also I can't update this commit past fd62fba9855c9cf8fe17eb9363e03f93563d9dc3 because that removed
;support for automatic integer conversion of enums, which discordpp endpoints also expects.
(define fmt-next
	(package
		(inherit fmt)
		(version "8.0.2-prerelease")
		(source
			(origin
				(method git-fetch)
				(uri
					(git-reference
						(url "https://github.com/fmtlib/fmt.git")
						(commit "c652f8243a5f8e50584d2a81c8c5714e74a03955")))
				(sha256
					(base32
						"1qx7wj60dphnmmhsxyn1bj4askch3qm9571b2x6qs2ila269xc32"))))))

(package
	(name "discordpp-echo-bot")
	(version "0.0")
	(inputs
		`(("boost" ,boost)
		("json-modern-cxx" ,json-modern-cxx)
		("openssl" ,openssl)
		("fmt" ,fmt-next)
		("discordpp" ,(load "./lib/discordpp/package.scm"))
		("plugin-endpoints" ,(load "./lib/plugin-endpoints/package.scm"))
		("plugin-overload" ,(load "./lib/plugin-overload/package.scm"))
		("plugin-ratelimit" ,(load "./lib/plugin-ratelimit/package.scm"))
		("plugin-responder" ,(load "./lib/plugin-responder/package.scm"))
		("plugin-interactionhandler" ,(load "./lib/plugin-interactionhandler/package.scm"))
		("rest-simpleweb" ,(load "./lib/rest-simpleweb/package.scm"))
		("websocket-simpleweb" ,(load "./lib/websocket-simpleweb/package.scm"))
		("simple-web-server" ,(load "./lib/rest-simpleweb/simple-web-server-package.scm"))
		("simple-websocket-server" ,(load "./lib/websocket-simpleweb/simple-websocket-server-package.scm"))))
	(native-inputs 
		`(("pkg-config" ,pkg-config)
		("cmake" ,cmake)
		;("clang-toolchain" ,clang-toolchain)
		;("gcc-toolchain" ,gcc-toolchain)
		))
	(propagated-inputs '())
	(source (local-file (dirname (current-filename)) #:recursive? #t))
	(build-system meson-build-system)
	(synopsis "Discord++: A Modularized C++ Library for the Discord API echo-bot")
	(description
		"A Modularized C++ Library for the Discord API example echo-bot implementation")
	(home-page "https://github.com/Discordpp/echo-bot")
	(license license:gpl2+))

