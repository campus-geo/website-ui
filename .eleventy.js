const shortcodes = import("./src/_includes/components/shortcode.js");

export default function(eleventyConfig) {
    eleventyConfig.setInputDirectory("src");
    eleventyConfig.setIncludesDirectory('_includes');
    eleventyConfig.setLayoutsDirectory("_layouts");
    eleventyConfig.setOutputDirectory("www");

    for (let shortcodesKey in shortcodes) {
        eleventyConfig.addShortcode(shortcodesKey, shortcodes[shortcodesKey]);
    }

    eleventyConfig.addPassthroughCopy({"js/*.js": "assets/js" });

    eleventyConfig.setServerPassthroughCopyBehavior("passthrough");
};