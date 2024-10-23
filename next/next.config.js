const nextConfig = {
    reactStrictMode: false, 
    // distDir: '/../public_html/site/export',
    // output: "export",
    // useFileSystemPublicRoutes: false,
    // experimental: { esmExternals: true },
    images: {
        domains: ['127.0.0.1','lmsapi.ictvu.com']
    },
    webpack: (config) => {
        config.resolve.alias.canvas = false;

        return config;
    },
}
module.exports = nextConfig