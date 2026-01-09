{ lib, config, pkgs, ... }:

{
  programs.newsboat = {
    enable = true;
    urls = [
      {
        url = "https://scottaaronson.blog/?feed=rss2";
        tags = [ "cs" "complexity" ];
        title = "Shtetl-optimized";
      }
      {
        url = "https://bernsteinbear.com/feed.xml";
        tags = [ "cs" "compilers"];
        title = "Bernsteinbear";
      }
      {
        url = "https://www.dogeystamp.com/atom.xml";
        tags = [ "cs" "niche" ];
        title = "dogeystamp";
      }
      {
        url = "https://terrytao.wordpress.com/feed/";
        tags = [ "math" "formal-verification" ];
        title = "Terrance Tao's Blog";
      }
      {
        url = "https://austinhenley.com/blog/feed.rss";
        tags = [ "cs" "ai" ];
        title = "Austin Z. Henley's Blog";
      }
      {
        url = "https://dotat.at/@/blog.atom";
        tags = [ "cs" "optimization" ];
        title = "Tony Finch's blog";
      }
      {
        url = "https://matklad.github.io/feed.xml";
        tags = [ "cs" "programming-languages" ];
        title = "matklad";
      }
      {
        url = "https://smallcultfollowing.com/babysteps//atom.xml";
        tags = [ "cs" "rust" ];
        title = "smallcultfollowing";
      }
      {
        url = "https://buttondown.com/hillelwayne/rss";
        tags = [ "cs" "logic" ];
        title = "Computer things";
      }
      {
        url = "https://railsatscale.com/feed.xml";
        tags = [ "cs" "compilers" ];
        title = "Rails at scale";
      }
      {
        url = "https://www.brendangregg.com/blog/rss.xml";
        tags = [ "cs" "systems" ];
        title = "Brendan Gregg's Blog";
      }
      {
        url = "https://strongly-typed-thoughts.net/blog/feed";
        tags = [ "cs" "programming-languages" ];
        title = "Strongly typed thoughts";
      }
      {
        url = "https://ohadravid.github.io/index.xml";
        tags = [ "cs" "engineering" ];
        title = "Tea and Bits";
      }
    ];
    extraConfig = "
      # unbind keys
      unbind-key j
      unbind-key k
      unbind-key J
      unbind-key K

      # bind keys - vim style
      bind-key j down
      bind-key k up
    ";
  };
}
