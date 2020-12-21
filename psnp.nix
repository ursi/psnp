# generated by psnp 0.2.1
{ lib, pkgs }:
  let
    psPackages = {
      argonaut = builtins.fetchGit {
        url = "https://github.com/purescript-contrib/purescript-argonaut.git";
        rev = "2b81ce16b4c0e8cac0be88b4bf616523b6ddda56";
        ref = "refs/tags/v7.0.0";
      };

      argonaut-codecs = builtins.fetchGit {
        url = "https://github.com/purescript-contrib/purescript-argonaut-codecs.git";
        rev = "9b00fcc6b04bd999d3fd3b9de2ae830bff473a71";
        ref = "refs/tags/v7.0.0";
      };

      argonaut-core = builtins.fetchGit {
        url = "https://github.com/purescript-contrib/purescript-argonaut-core.git";
        rev = "6b170102ec5762f13cb096917757c85b74e73ed0";
        ref = "refs/tags/v5.1.0";
      };

      argonaut-traversals = builtins.fetchGit {
        url = "https://github.com/purescript-contrib/purescript-argonaut-traversals.git";
        rev = "9543b517011a4dbc66dfd5cd4d8d774aa620b764";
        ref = "refs/tags/v8.0.0";
      };

      arraybuffer-types = builtins.fetchGit {
        url = "https://github.com/purescript-contrib/purescript-arraybuffer-types.git";
        rev = "505aa3de50a1400e5f2fce4a8e7b1a39abaa8fd9";
        ref = "refs/tags/v2.0.0";
      };

      arrays = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-arrays.git";
        rev = "9a7e6b4a4edd9c7a88f3085a417dd79b25462141";
        ref = "refs/tags/v5.3.1";
      };

      bifunctors = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-bifunctors.git";
        rev = "1062425892b4a1c734ec653dded22546e3063b27";
        ref = "refs/tags/v4.0.0";
      };

      console = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-console.git";
        rev = "9b48f83997168b94418d64d9e7b5c1763b30bdab";
        ref = "refs/tags/v4.4.0";
      };

      const = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-const.git";
        rev = "bc5db27b0ed3947fa5e2074ccbab01236eec3fa4";
        ref = "refs/tags/v4.1.0";
      };

      contravariant = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-contravariant.git";
        rev = "cb69db0253c2e2ed3fef784dad58f3418a8ee834";
        ref = "refs/tags/v4.0.1";
      };

      control = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-control.git";
        rev = "05d40c5855a0eda3bc396a3d815eaf213a0534e6";
        ref = "refs/tags/v4.2.0";
      };

      datetime = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-datetime.git";
        rev = "9e76abe96f45a68eb0bb23d0afd56031a8070bee";
        ref = "refs/tags/v4.1.1";
      };

      debuggest = builtins.fetchGit {
        url = "https://github.com/ursi/purescript-debuggest.git";
        rev = "d2bca6d8e358c7d3785ffc5af7fb61de0a67378b";
        ref = "refs/tags/v0.4.0";
      };

      distributive = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-distributive.git";
        rev = "3a43c0690883816e9ebeac510698423cfff5c174";
        ref = "refs/tags/v4.0.0";
      };

      effect = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-effect.git";
        rev = "d2a11e69abcda3b81c750e86e8746cda278f47bf";
        ref = "refs/tags/v2.0.1";
      };

      either = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-either.git";
        rev = "8b4b38a729f8e88750b03e5c7baf2b3863ce4742";
        ref = "refs/tags/v4.1.1";
      };

      enums = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-enums.git";
        rev = "3722b87ee4b3575d1edae916250a1ccf34e857a9";
        ref = "refs/tags/v4.0.1";
      };

      exceptions = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-exceptions.git";
        rev = "9012eb08749e9ccd5da45bdece5d576e5fc0b0db";
        ref = "refs/tags/v4.0.0";
      };

      exists = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-exists.git";
        rev = "ef53359aebc09bf863800ca86ad1dcd76f0b08ae";
        ref = "refs/tags/v4.0.0";
      };

      foldable-traversable = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-foldable-traversable.git";
        rev = "29d5b873cc86f17e0082d777629819a96bdbc7a1";
        ref = "refs/tags/v4.1.1";
      };

      foreign = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-foreign.git";
        rev = "3b8f3ae608db339ed5cff35d2017a07efb905b4d";
        ref = "refs/tags/v5.0.0";
      };

      foreign-object = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-foreign-object.git";
        rev = "8a7dc21c48e3e6d31e253b0e58dd95a3bbd7f6e7";
        ref = "refs/tags/v2.0.3";
      };

      functions = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-functions.git";
        rev = "c63451ae74f6fba7a4eede5f87208a73c537af77";
        ref = "refs/tags/v4.0.0";
      };

      functors = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-functors.git";
        rev = "96bcf8a970a40115a76a20d19e50aa3b524adcf3";
        ref = "refs/tags/v3.1.1";
      };

      gen = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-gen.git";
        rev = "36f36f03f082b57e402c27f1513f8935caa54101";
        ref = "refs/tags/v2.1.1";
      };

      generics-rep = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-generics-rep.git";
        rev = "1f51347e525769c8f5a9cef7a3fcd78e4d4039d8";
        ref = "refs/tags/v6.1.1";
      };

      globals = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-globals.git";
        rev = "8e6d69c36b6fd8c988a3664fc033ad11dbdd5860";
        ref = "refs/tags/v4.1.0";
      };

      identity = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-identity.git";
        rev = "1b7938abdc8cb28c0ac5f80f63405d53e3173a8e";
        ref = "refs/tags/v4.1.0";
      };

      integers = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-integers.git";
        rev = "3850da9cd96b37c71685b6bc3bf0cb489baefc93";
        ref = "refs/tags/v4.0.0";
      };

      invariant = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-invariant.git";
        rev = "b704c5bda262719ca5cc88a3f8554edff8f03256";
        ref = "refs/tags/v4.1.0";
      };

      js-date = builtins.fetchGit {
        url = "https://github.com/purescript-contrib/purescript-js-date.git";
        rev = "f332c15f14322434ddd1945ca2db8040294447bf";
        ref = "refs/tags/v6.0.0";
      };

      js-timers = builtins.fetchGit {
        url = "https://github.com/purescript-contrib/purescript-js-timers.git";
        rev = "b88b0c6e2546b49c5b20e54eb6e1b148cd0e1f9d";
        ref = "refs/tags/v4.0.1";
      };

      lazy = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-lazy.git";
        rev = "5bbd04f507a704f39aa756b5e12ed6665205fe2e";
        ref = "refs/tags/v4.0.0";
      };

      lists = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-lists.git";
        rev = "62900a56f6864638c952575dfd211a1cc55be7da";
        ref = "refs/tags/v5.4.1";
      };

      mason-prelude = builtins.fetchGit {
        url = "https://github.com/ursi/purescript-mason-prelude.git";
        rev = "27ceb84b8556f042d8c4ae1f60de767e28207108";
        ref = "refs/tags/v0.5.0";
      };

      math = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-math.git";
        rev = "8be36d24f9d2d8795adf04791446bbc458297b9b";
        ref = "refs/tags/v2.1.1";
      };

      maybe = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-maybe.git";
        rev = "81f0397636bcbca28642f62421aebfd9e1afa7fb";
        ref = "refs/tags/v4.0.1";
      };

      newtype = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-newtype.git";
        rev = "7d85fa6a040208c010b05f7c23af6a943ba08763";
        ref = "refs/tags/v3.0.0";
      };

      node-buffer = builtins.fetchGit {
        url = "https://github.com/purescript-node/purescript-node-buffer.git";
        rev = "dac7d4734a739cea2cd379f6bae5226dbab26da2";
        ref = "refs/tags/v6.0.0";
      };

      node-child-process = builtins.fetchGit {
        url = "https://github.com/purescript-node/purescript-node-child-process.git";
        rev = "887b252ef85975f4cf31dfd9079f6d98d905fc1b";
        ref = "refs/tags/v6.0.0";
      };

      node-fs = builtins.fetchGit {
        url = "https://github.com/purescript-node/purescript-node-fs.git";
        rev = "95f7334cfb5f5bd6a9c4029f6fc34c4f74dd1cad";
        ref = "refs/tags/v5.0.1";
      };

      node-path = builtins.fetchGit {
        url = "https://github.com/purescript-node/purescript-node-path.git";
        rev = "e3a704d5fc7d25fa93c6cd0eb92dbce9e5ebd69a";
        ref = "refs/tags/v3.0.0";
      };

      node-process = builtins.fetchGit {
        url = "https://github.com/purescript-node/purescript-node-process.git";
        rev = "88871d84a69f47dd2d1d9eccd7cc942be4457d46";
        ref = "refs/tags/v7.0.0";
      };

      node-streams = builtins.fetchGit {
        url = "https://github.com/purescript-node/purescript-node-streams.git";
        rev = "7eb83907dac0ad064dc3197a4464c7a533982c13";
        ref = "refs/tags/v4.0.1";
      };

      nonempty = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-nonempty.git";
        rev = "36ca3b2fa6d98b1c9d2ee05643341e496fbeab57";
        ref = "refs/tags/v5.0.0";
      };

      now = builtins.fetchGit {
        url = "https://github.com/purescript-contrib/purescript-now.git";
        rev = "090feddf7c7dec2a812eca090cd211e87ccad606";
        ref = "refs/tags/v4.0.0";
      };

      nullable = builtins.fetchGit {
        url = "https://github.com/purescript-contrib/purescript-nullable.git";
        rev = "b62b4fc4ed561f2afe2e838c0dd6568a6728102a";
        ref = "refs/tags/v4.1.1";
      };

      ordered-collections = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-ordered-collections.git";
        rev = "3089988c5a143f1d4fb0b85c7e3cf8da364272be";
        ref = "refs/tags/v1.6.1";
      };

      orders = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-orders.git";
        rev = "80e22c22c72c846e09ef9dfcdb40b3eee39118d6";
        ref = "refs/tags/v4.0.0";
      };

      parallel = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-parallel.git";
        rev = "4d6c8b05041a36c300dfca2ba8f1f3443ca26bc6";
        ref = "refs/tags/v4.0.0";
      };

      partial = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-partial.git";
        rev = "b7bbfa930814c9d58d981beedf238f57f881b84d";
        ref = "refs/tags/v2.0.1";
      };

      point-free = builtins.fetchGit {
        url = "https://github.com/ursi/purescript-point-free.git";
        rev = "55d146b104881e3696b150ca48b4b33a82e99b9d";
        ref = "refs/tags/v0.1.1";
      };

      posix-types = builtins.fetchGit {
        url = "https://github.com/purescript-node/purescript-posix-types.git";
        rev = "1d4cd274436cc1e470dc6bf7735bcfdf0092d884";
        ref = "refs/tags/v4.0.0";
      };

      prelude = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-prelude.git";
        rev = "8c0a45c20e76c7571c2fb31b21fced1682e6c980";
        ref = "refs/tags/v4.1.1";
      };

      profunctor = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-profunctor.git";
        rev = "9b3d014b38c69ea2dd4b1f597330b095034fe2c4";
        ref = "refs/tags/v4.1.0";
      };

      profunctor-lenses = builtins.fetchGit {
        url = "https://github.com/purescript-contrib/purescript-profunctor-lenses.git";
        rev = "2be610e104ab733a4dcc9d63f03d8eaee1e1b1c2";
        ref = "refs/tags/v6.3.0";
      };

      proxy = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-proxy.git";
        rev = "4a529b1f874fa2f32fc4c575cafaf46e0ab69fb6";
        ref = "refs/tags/v3.0.0";
      };

      record = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-record.git";
        rev = "8f4341072cb9122f3acd6684390817015b6b655b";
        ref = "refs/tags/v2.0.2";
      };

      refs = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-refs.git";
        rev = "e8b175477661e433175e76548168290c40e0ce4b";
        ref = "refs/tags/v4.1.0";
      };

      return = builtins.fetchGit {
        url = "https://github.com/ursi/purescript-return.git";
        rev = "5cd957172f7aeecbbc4eba771c019b680f1ec715";
        ref = "refs/heads/master";
      };

      st = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-st.git";
        rev = "8133841b8b545f3a273caebb6103f7c640fc35eb";
        ref = "refs/tags/v4.1.1";
      };

      strings = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-strings.git";
        rev = "ec6da8faa02112a82286c0ff1c5e8fccd969ca42";
        ref = "refs/tags/v4.0.2";
      };

      substitute = builtins.fetchGit {
        url = "https://github.com/ursi/purescript-substitute.git";
        rev = "8ec2d1854d63d36510871966d904841b0a994a3c";
        ref = "refs/tags/v0.1.1";
      };

      tailrec = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-tailrec.git";
        rev = "6e26342de46336c7af35c79e355d98721b7c0bb0";
        ref = "refs/tags/v4.1.1";
      };

      task = builtins.fetchGit {
        url = "https://github.com/ursi/purescript-task.git";
        rev = "13468718522f4e8f95d334905c40c3c9732c217c";
        ref = "refs/tags/v0.3.0";
      };

      task-file = builtins.fetchGit {
        url = "https://github.com/ursi/purescript-task-file.git";
        rev = "c6fca2e315e39aa4892cdc3eae1081798c444f73";
        ref = "refs/tags/v0.1.0";
      };

      task-node-child-process = builtins.fetchGit {
        url = "https://github.com/ursi/purescript-task-node-child-process.git";
        rev = "3dbd16412fd04f15bac97d3359afabaf546b9d01";
        ref = "refs/tags/v0.1.0";
      };

      transformers = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-transformers.git";
        rev = "4bf2497b219e1da101abe8955a21889e656789a0";
        ref = "refs/tags/v4.2.0";
      };

      tuples = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-tuples.git";
        rev = "0036bf9d99b721fd0f2e539d24e18e484b016927";
        ref = "refs/tags/v5.1.0";
      };

      type-equality = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-type-equality.git";
        rev = "2cdae51c394401cd5fc04b03c341273b41532b7d";
        ref = "refs/tags/v3.0.0";
      };

      typelevel-prelude = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-typelevel-prelude.git";
        rev = "71366c5bcc3182cec69fe0b26d15f028d17393f9";
        ref = "refs/tags/v5.0.2";
      };

      unfoldable = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-unfoldable.git";
        rev = "077e787108e02bd16a1b27e57847d5baede7dd61";
        ref = "refs/tags/v4.1.0";
      };

      unsafe-coerce = builtins.fetchGit {
        url = "https://github.com/purescript/purescript-unsafe-coerce.git";
        rev = "fa6a5ca9b4581c00ee0b8539306a49badb7bee60";
        ref = "refs/tags/v4.0.0";
      };
    };

    mkInstallPhase = args: ''
        mkdir -p $out/bin
        mkdir -p $out/lib
        cp index.js $out/lib
        echo "if [[ \$1 = --version ]]; then
          echo $version
        else
          export PATH=$PATH
          node $out/lib/index.js ${args}
        fi" > $out/bin/psnp
        chmod +x $out/bin/psnp
    '';
  in
    with pkgs;
    stdenv.mkDerivation {
      pname = lib.strings.sanitizeDerivationName "psnp";
      version = "0.2.1";
      nativeBuildInputs = [ purescript ];
      buildInputs = [ nodejs ];
      dontUnpack = true;
      src = ./src;

      buildPhase = ''
        mkdir sources/

        ${
          builtins.concatStringsSep ";"
          (map
            (name: "ln -rs ${psPackages.${name}} sources/${name}")
            (builtins.attrNames psPackages)
          )
        }

        purs compile "sources/argonaut/src/**/*.purs" "sources/argonaut-codecs/src/**/*.purs" "sources/argonaut-core/src/**/*.purs" "sources/argonaut-traversals/src/**/*.purs" "sources/arraybuffer-types/src/**/*.purs" "sources/arrays/src/**/*.purs" "sources/bifunctors/src/**/*.purs" "sources/console/src/**/*.purs" "sources/const/src/**/*.purs" "sources/contravariant/src/**/*.purs" "sources/control/src/**/*.purs" "sources/datetime/src/**/*.purs" "sources/debuggest/src/**/*.purs" "sources/distributive/src/**/*.purs" "sources/effect/src/**/*.purs" "sources/either/src/**/*.purs" "sources/enums/src/**/*.purs" "sources/exceptions/src/**/*.purs" "sources/exists/src/**/*.purs" "sources/foldable-traversable/src/**/*.purs" "sources/foreign/src/**/*.purs" "sources/foreign-object/src/**/*.purs" "sources/functions/src/**/*.purs" "sources/functors/src/**/*.purs" "sources/gen/src/**/*.purs" "sources/generics-rep/src/**/*.purs" "sources/globals/src/**/*.purs" "sources/identity/src/**/*.purs" "sources/integers/src/**/*.purs" "sources/invariant/src/**/*.purs" "sources/js-date/src/**/*.purs" "sources/js-timers/src/**/*.purs" "sources/lazy/src/**/*.purs" "sources/lists/src/**/*.purs" "sources/mason-prelude/src/**/*.purs" "sources/math/src/**/*.purs" "sources/maybe/src/**/*.purs" "sources/newtype/src/**/*.purs" "sources/node-buffer/src/**/*.purs" "sources/node-child-process/src/**/*.purs" "sources/node-fs/src/**/*.purs" "sources/node-path/src/**/*.purs" "sources/node-process/src/**/*.purs" "sources/node-streams/src/**/*.purs" "sources/nonempty/src/**/*.purs" "sources/now/src/**/*.purs" "sources/nullable/src/**/*.purs" "sources/ordered-collections/src/**/*.purs" "sources/orders/src/**/*.purs" "sources/parallel/src/**/*.purs" "sources/partial/src/**/*.purs" "sources/point-free/src/**/*.purs" "sources/posix-types/src/**/*.purs" "sources/prelude/src/**/*.purs" "sources/profunctor/src/**/*.purs" "sources/profunctor-lenses/src/**/*.purs" "sources/proxy/src/**/*.purs" "sources/record/src/**/*.purs" "sources/refs/src/**/*.purs" "sources/return/src/**/*.purs" "sources/st/src/**/*.purs" "sources/strings/src/**/*.purs" "sources/substitute/src/**/*.purs" "sources/tailrec/src/**/*.purs" "sources/task/src/**/*.purs" "sources/task-file/src/**/*.purs" "sources/task-node-child-process/src/**/*.purs" "sources/transformers/src/**/*.purs" "sources/tuples/src/**/*.purs" "sources/type-equality/src/**/*.purs" "sources/typelevel-prelude/src/**/*.purs" "sources/unfoldable/src/**/*.purs" "sources/unsafe-coerce/src/**/*.purs" "$src/**/*.purs"

        purs bundle "output/*/*.js" -m Main --main Main -o index.js
      '';

      passthru = {
        inherit mkInstallPhase;
      };

      installPhase = mkInstallPhase "\$@";
    }
