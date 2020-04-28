variable "amis" {
  description = "MarkLogic AMIs by region"
  type        = map(string)

  default = {
    // <editor-fold desc="MarkLogic 10.0-3 AMIs">
    "v10.0-3.us-east-1.enterprise"      = "ami-08bde30b7728b773c"
    "v10.0-3.us-east-1.byol"            = "ami-0a89489a18c15493d"
    "v10.0-3.us-east-2.enterprise"      = "ami-0232f94a147187569"
    "v10.0-3.us-east-2.byol"            = "ami-01d15f077ed94438c"
    "v10.0-3.us-west-1.enterprise"      = "ami-08e32f0223963d22f"
    "v10.0-3.us-west-1.byol"            = "ami-0219a3c826714a65a"
    "v10.0-3.us-west-2.enterprise"      = "ami-0370cee9c1c2d2046"
    "v10.0-3.us-west-2.byol"            = "ami-0c27c3b5f896e297a"
    "v10.0-3.eu-central-1.enterprise"   = "ami-0141fdbda2662ea6c"
    "v10.0-3.eu-central-1.byol"         = "ami-0ca626355eed1258e"
    "v10.0-3.eu-west-1.enterprise"      = "ami-0da04d4cc332cb09a"
    "v10.0-3.eu-west-1.byol"            = "ami-05cc544ba6bec0451"
    "v10.0-3.ap-south-1.enterprise"     = "ami-03df88db26f87a9fd"
    "v10.0-3.ap-south-1.byol"           = "ami-085e17bb4ac2b2d48"
    "v10.0-3.ap-southeast-1.enterprise" = "ami-0d048c93c4ea1c699"
    "v10.0-3.ap-southeast-1.byol"       = "ami-041f7e5ed8c733fda"
    "v10.0-3.ap-southeast-2.enterprise" = "ami-0f575ad2081a65c11"
    "v10.0-3.ap-southeast-2.byol"       = "ami-0422b257d0a45c1db"
    "v10.0-3.ap-northeast-1.enterprise" = "ami-083569a68138c36fb"
    "v10.0-3.ap-northeast-1.byol"       = "ami-0ef3661fb348d4105"
    "v10.0-3.ap-northeast-2.enterprise" = "ami-03e3cac31a9f3e042"
    "v10.0-3.ap-northeast-2.byol"       = "ami-010a8db965dac38d0"
    "v10.0-3.sa-east-1.enterprise"      = "ami-07d7e31894ae8e0d5"
    "v10.0-3.sa-east-1.byol"            = "ami-04a546a9d226bd122"
    "v10.0-3.eu-west-2.enterprise"      = "ami-09a7851f4bb16fa63"
    "v10.0-3.eu-west-2.byol"            = "ami-01fc3b3bc2679ce15"
    "v10.0-3.ca-central-1.enterprise"   = "ami-017740cf6337af37a"
    "v10.0-3.ca-central-1.byol"         = "ami-05f88dd42f74bd436"
    "v10.0-3.eu-west-3.enterprise"      = "ami-0eb17b12d06de3e06"
    "v10.0-3.eu-west-3.byol"            = "ami-09acf0e900303b6d2"
    // </editor-fold>


    // <editor-fold desc="MarkLogic 10.0-2.1 AMIs">
    "v10.0-2.1.us-east-1.enterprise"      = "ami-072ec2a77547f9ea5"
    "v10.0-2.1.us-east-1.byol"            = "ami-0ade534db8b60a808"
    "v10.0-2.1.us-east-2.enterprise"      = "ami-01cf2c036c33ece29"
    "v10.0-2.1.us-east-2.byol"            = "ami-0785d0d3b8be3a50f"
    "v10.0-2.1.us-west-1.enterprise"      = "ami-0202b9fe50ffe4ca7"
    "v10.0-2.1.us-west-1.byol"            = "ami-0dfbde2e96e550432"
    "v10.0-2.1.us-west-2.enterprise"      = "ami-031932618fae4c2b3"
    "v10.0-2.1.us-west-2.byol"            = "ami-0bbd7ce6e998eeb02"
    "v10.0-2.1.eu-central-1.enterprise"   = "ami-05fb73ae436f4cc53"
    "v10.0-2.1.eu-central-1.byol"         = "ami-0e4a73dba06357e3e"
    "v10.0-2.1.eu-west-1.enterprise"      = "ami-033498e07c823a88c"
    "v10.0-2.1.eu-west-1.byol"            = "ami-02a3220855f8b0138"
    "v10.0-2.1.ap-south-1.enterprise"     = "ami-04aa2b458e0d67c55"
    "v10.0-2.1.ap-south-1.byol"           = "ami-0497e825c3e141e1e"
    "v10.0-2.1.ap-southeast-1.enterprise" = "ami-0a41f5094cd3a40e9"
    "v10.0-2.1.ap-southeast-1.byol"       = "ami-057541533bfa09aed"
    "v10.0-2.1.ap-southeast-2.enterprise" = "ami-0f9a0bff08cc6b199"
    "v10.0-2.1.ap-southeast-2.byol"       = "ami-07d7cb987a959a5eb"
    "v10.0-2.1.ap-northeast-1.enterprise" = "ami-09a55d5e48d2a1351"
    "v10.0-2.1.ap-northeast-1.byol"       = "ami-0244b97f9bec76f51"
    "v10.0-2.1.ap-northeast-2.enterprise" = "ami-0a74dcad4c72fa457"
    "v10.0-2.1.ap-northeast-2.byol"       = "ami-06b3dfc2d3efe96d3"
    "v10.0-2.1.sa-east-1.enterprise"      = "ami-056975e34509c0595"
    "v10.0-2.1.sa-east-1.byol"            = "ami-0e6c2870b6d67e502"
    "v10.0-2.1.eu-west-2.enterprise"      = "ami-0b650def8b9d17143"
    "v10.0-2.1.eu-west-2.byol"            = "ami-0a769f4f99a22b4ba"
    "v10.0-2.1.ca-central-1.enterprise"   = "ami-05bd66d8ba9aadd19"
    "v10.0-2.1.ca-central-1.byol"         = "ami-08d6648938dfe7b07"
    "v10.0-2.1.eu-west-3.enterprise"      = "ami-058c46da4557aab01"
    "v10.0-2.1.eu-west-3.byol"            = "ami-0fcabc1d12a02840f"
    "v10.0-2.1.us-gov-west-1.enterprise"  = null
    "v10.0-2.1.us-gov-west-1.byol"        = null
    // </editor-fold>

    // <editor-fold desc="MarkLogic 10.0-2.1 AMIs">
    "v10.0-1.us-east-1.enterprise"  = "ami-0ac019c39cac73c89"
    "v10.0-1.us-east-1.byol"	= "ami-0ea837234c4c34363"
    "v10.0-1.us-east-2.enterprise"	= "ami-04a12854191a13598"
    "v10.0-1.us-east-2.byol"	= "ami-064a52b106d703e95"
    "v10.0-1.us-west-1.enterprise"	= "ami-03e26454a0467260b"
    "v10.0-1.us-west-1.byol"	= "ami-055e79ea1dfe9bbbe"
    "v10.0-1.us-west-2.enterprise"	= "ami-02ef9bed5ba506f1d"
    "v10.0-1.us-west-2.byol"	= "ami-03c7c175abb66d3b6"
    "v10.0-1.eu-central-1.enterprise"	= "ami-022a0caaf9f11373d"
    "v10.0-1.eu-central-1.byol"	= "ami-01ab6f1d51c0b4468"
    "v10.0-1.eu-west-1.enterprise"	= "ami-051ee31e10ba0bdab"
    "v10.0-1.eu-west-1.byol"	= "ami-060fd630c85814af2"
    "v10.0-1.ap-south-1.enterprise"	= "ami-012f367ee8a0db5c9"
    "v10.0-1.ap-south-1.byol"	= "ami-081563b3e7c3b89fa"
    "v10.0-1.ap-southeast-1.enterprise"	= "ami-06e61a8a08a11f8cc"
    "v10.0-1.ap-southeast-1.byol"	= "ami-07016ac9cb73cb378"
    "v10.0-1.ap-southeast-2.enterprise"	= "ami-00a20b1ab84175504"
    "v10.0-1.ap-southeast-2.byol"	= "ami-028f3c7e8621413e8"
    "v10.0-1.ap-northeast-1.enterprise"	= "ami-0a2788d3e6623b6cd"
    "v10.0-1.ap-northeast-1.byol"	= "ami-0ab5f8f75ab1f78a8"
    "v10.0-1.ap-northeast-2.enterprise"	= "ami-056eb302dff17109f"
    "v10.0-1.ap-northeast-2.byol"	= "ami-029bdb1e9ac3d8263"
    "v10.0-1.sa-east-1.enterprise"	= "ami-0da5e718b806460c4"
    "v10.0-1.sa-east-1.byol"	= "ami-0b2ae39de3c28c9cf"
    "v10.0-1.eu-west-2.enterprise"	= "ami-040c2fbe7312fef0b"
    "v10.0-1.eu-west-2.byol"	= "ami-09a2360870f519792"
    "v10.0-1.ca-central-1.enterprise"	= "ami-0df9061e4de340b68"
    "v10.0-1.ca-central-1.byol"	= "ami-07f889af9d0bbfb57"
    "v10.0-1.eu-west-3.enterprise"	= "ami-0dce77e59a26b5327"
    "v10.0-1.eu-west-3.byol"	= "ami-01fa2a870cf1b32f5"
    // </editor-fold>

    // <editor-fold desc="MarkLogic 9.0-9.3 AMIs">
    "v9.0-9.3.us-east-1.enterprise"      = "ami-0c47fb9f2fd80d605"
    "v9.0-9.3.us-east-1.byol"            = "ami-0e039c2bef4b3d333"
    "v9.0-9.3.us-east-2.enterprise"      = "ami-053e513556bd27d6f"
    "v9.0-9.3.us-east-2.byol"            = "ami-0c30f95be4b2e43e5"
    "v9.0-9.3.us-west-1.enterprise"      = "ami-0a5fb3af268e2db3b"
    "v9.0-9.3.us-west-1.byol"            = "ami-08b63a39de08fff4a"
    "v9.0-9.3.us-west-2.enterprise"      = "ami-0b06719af803f0393"
    "v9.0-9.3.us-west-2.byol"            = "ami-0dd72dd4bf12873ba"
    "v9.0-9.3.eu-central-1.enterprise"   = "ami-0c0a363d12b1436a3"
    "v9.0-9.3.eu-central-1.byol"         = "ami-055c758d6bf6f156a"
    "v9.0-9.3.eu-west-1.enterprise"      = "ami-0821dfb8affeda44e"
    "v9.0-9.3.eu-west-1.byol"            = "ami-0d03b1cff59db0899"
    "v9.0-9.3.ap-south-1.enterprise"     = "ami-0a4d2fdb3c1b96aac"
    "v9.0-9.3.ap-south-1.byol"           = "ami-0f1c33a7aa6eb5b26"
    "v9.0-9.3.ap-southeast-1.enterprise" = "ami-0ce17f2e5bc92387e"
    "v9.0-9.3.ap-southeast-1.byol"       = "ami-023d4130bf18481b9"
    "v9.0-9.3.ap-southeast-2.enterprise" = "ami-001f8eae9bfa115ee"
    "v9.0-9.3.ap-southeast-2.byol"       = "ami-0f9f8ebca6d2437f7"
    "v9.0-9.3.ap-northeast-1.enterprise" = "ami-08e8ff2164b03f4d5"
    "v9.0-9.3.ap-northeast-1.byol"       = "ami-091ccdb6c55536dd6"
    "v9.0-9.3.ap-northeast-2.enterprise" = "ami-0c45f120699777a59"
    "v9.0-9.3.ap-northeast-2.byol"       = "ami-07f0e3519db3b9807"
    "v9.0-9.3.sa-east-1.enterprise"      = "ami-00f9503c2c19.3759"
    "v9.0-9.3.sa-east-1.byol"            = "ami-0c6cf678332b338e9"
    "v9.0-9.3.eu-west-2.enterprise"      = "ami-0ec255fcb2df832b9"
    "v9.0-9.3.eu-west-2.byol"            = "ami-0c3579a5b6cf37780"
    "v9.0-9.3.ca-central-1.enterprise"   = "ami-07be5eaad5de4bf58"
    "v9.0-9.3.ca-central-1.byol"         = "ami-05a6bd73b5746bfe6"
    "v9.0-9.3.eu-west-3.enterprise"      = "ami-0d4fc1e700ff08f48"
    "v9.0-9.3.eu-west-3.byol"            = "ami-089466e371ab9.38d"
    "v9.0-9.3.us-gov-west-1.enterprise"  = null
    "v9.0-9.3.us-gov-west-1.byol"        = null
    // </editor-fold>

    // <editor-fold desc="MarkLogic 9.0-9.1 AMIs">
    "v9.0-9.1.us-east-1.enterprise"      = "ami-0004b449f1081f1d9"
    "v9.0-9.1.us-east-1.byol"            = "ami-08ffa9952f7b0e2fe"
    "v9.0-9.1.us-east-2.enterprise"      = "ami-0d3df3072fbf3d239"
    "v9.0-9.1.us-east-2.byol"            = "ami-046e17d4536ace88c"
    "v9.0-9.1.us-west-1.enterprise"      = "ami-0b0a553d3a5daa468"
    "v9.0-9.1.us-west-1.byol"            = "ami-097ef4a918e62c952"
    "v9.0-9.1.us-west-2.enterprise"      = "ami-012951e1864920579"
    "v9.0-9.1.us-west-2.byol"            = "ami-0a8d80a5367655adf"
    "v9.0-9.1.eu-central-1.enterprise"   = "ami-097cffe8c24d29ebc"
    "v9.0-9.1.eu-central-1.byol"         = "ami-05a5ab8a5ec63837e"
    "v9.0-9.1.eu-west-1.enterprise"      = "ami-0816b17b598804a4e"
    "v9.0-9.1.eu-west-1.byol"            = "ami-0042586977c058812"
    "v9.0-9.1.ap-south-1.enterprise"     = "ami-0713b92aa3834cf87"
    "v9.0-9.1.ap-south-1.byol"           = "ami-0adefbdd1b6b4c4d2"
    "v9.0-9.1.ap-southeast-1.enterprise" = "ami-03064b571404fd1ca"
    "v9.0-9.1.ap-southeast-1.byol"       = "ami-021f15fa5b57c4b09"
    "v9.0-9.1.ap-southeast-2.enterprise" = "ami-06e6a6ae435b897d8"
    "v9.0-9.1.ap-southeast-2.byol"       = "ami-0b35d6a43c7e8057b"
    "v9.0-9.1.ap-northeast-1.enterprise" = "ami-013d8d8da1532753e"
    "v9.0-9.1.ap-northeast-1.byol"       = "ami-0e3d01da785139a18"
    "v9.0-9.1.ap-northeast-2.enterprise" = "ami-0063b0d018835b2d5"
    "v9.0-9.1.ap-northeast-2.byol"       = "ami-0ead19500e8ebdeb3"
    "v9.0-9.1.sa-east-1.enterprise"      = "ami-0069f91e3f46020ec"
    "v9.0-9.1.sa-east-1.byol"            = "ami-0b6da6963ea03cfea"
    "v9.0-9.1.eu-west-2.enterprise"      = "ami-0a4c000ede045a037"
    "v9.0-9.1.eu-west-2.byol"            = "ami-073941dc2266a373d"
    "v9.0-9.1.ca-central-1.enterprise"   = "ami-0a027410ae54421fe"
    "v9.0-9.1.ca-central-1.byol"         = "ami-058b813db3fbe01c7"
    "v9.0-9.1.eu-west-3.enterprise"      = "ami-05af786bcb3ce0002"
    "v9.0-9.1.eu-west-3.byol"            = "ami-0aa5f39e9e66c4e8c"
    "v9.0-9.1.us-gov-west-1.enterprise"  = null
    "v9.0-9.1.us-gov-west-1.byol"        = null
    // </editor-fold>

    // <editor-fold desc="MarkLogic 9.0-8 AMIs">
    "v9.0-8.us-east-1.enterprise"      = "ami-0cd873f9b5dbbe54c"
    "v9.0-8.us-east-1.byol"            = "ami-0d77ce6990428613f"
    "v9.0-8.us-east-2.enterprise"      = "ami-0e04f31930f7f8d05"
    "v9.0-8.us-east-2.byol"            = "ami-0cf880d594b0ce4de"
    "v9.0-8.us-west-1.enterprise"      = "ami-01d0d25b2732378b1"
    "v9.0-8.us-west-1.byol"            = "ami-074db326064ccddbd"
    "v9.0-8.us-west-2.enterprise"      = "ami-063958e84eee7b4cd"
    "v9.0-8.us-west-2.byol"            = "ami-0f5da6468457979f6"
    "v9.0-8.eu-central-1.enterprise"   = "ami-0624c5d8c3c9c4f29"
    "v9.0-8.eu-central-1.byol"         = "ami-014acd3f00b3c20ef"
    "v9.0-8.eu-west-1.enterprise"      = "ami-01444ac8e6dc4ade1"
    "v9.0-8.eu-west-1.byol"            = "ami-0ef97ede729f7af74"
    "v9.0-8.ap-south-1.enterprise"     = "ami-0f98173fbc40896cd"
    "v9.0-8.ap-south-1.byol"           = "ami-03eda65e8fcb7757f"
    "v9.0-8.ap-southeast-1.enterprise" = "ami-09384752c92c31088"
    "v9.0-8.ap-southeast-1.byol"       = "ami-090e04d1c0f7d9ccd"
    "v9.0-8.ap-southeast-2.enterprise" = "ami-0f4e383a94dfac906"
    "v9.0-8.ap-southeast-2.byol"       = "ami-00a45f49456220653"
    "v9.0-8.ap-northeast-1.enterprise" = "ami-0a192803d42a10633"
    "v9.0-8.ap-northeast-1.byol"       = "ami-0cfeab5f94399859f"
    "v9.0-8.ap-northeast-2.enterprise" = "ami-0960d223a6bba5d17"
    "v9.0-8.ap-northeast-2.byol"       = "ami-06b7a50dac858f326"
    "v9.0-8.sa-east-1.enterprise"      = "ami-09206693bcf8e33ed"
    "v9.0-8.sa-east-1.byol"            = "ami-017aed992876cd5c4"
    "v9.0-8.eu-west-2.enterprise"      = "ami-0fbe07b179c427f75"
    "v9.0-8.eu-west-2.byol"            = "ami-0da44368227f44710"
    "v9.0-8.ca-central-1.enterprise"   = "ami-0f9e4fe7475d2a280"
    "v9.0-8.ca-central-1.byol"         = "ami-0aee3dfa1dcbf7636"
    "v9.0-8.eu-west-3.enterprise"      = "ami-0923d3ceab261d093"
    "v9.0-8.eu-west-3.byol"            = "ami-0a64de09d0f5f2218"
    "v9.0-8.us-gov-west-1.enterprise"  = null
    "v9.0-8.us-gov-west-1.byol"        = null
    // </editor-fold>
  }
}
