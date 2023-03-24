# Overview

A repository for enforcing Cloudflare configuration states with Terraform IaC.

### Setting up a new CloudFlare site
## If Partial
1. If authoritative DNS for a site is outside of the cloudflare platform, a CNAME setup must be established by creating the zone as `type="partial"`. Otherwise, if this is a net new zone, select `type="full"`
2. A provided TXT record must be added to the authoritative DNS zone to verify domain ownership for Cloudflare.
3. CNAME proxied properties through Cloudflare with `example.com.cdn.cloudflare.net` setting at the authoritive vendor (i.e. akamai).

## If Full
1. Domain can be purchased through cloudflare or chosen registrar
2. Point registrar to the provided nameservers in the zone

### Origin Protections
1. It is imparative that all traffic routes through Cloudflare to be effective. As such, the origin should be restricted to only allow Cloudflare IP's
2. Update origin ingress whitelist to allow the following:
   - https://www.cloudflare.com/ips-v4

## Build and Test

You must have a Cloudflare API token created to run this stack. To generate a token:

* Log in to Cloudflare.
* Open your user menu and select My Profile.
* Go to the API Tokens tab.

(To add here: what specific permissions are required for this token.)

Once you have a token you must set it in the current terminal session.

```Powershell
$env:CLOUDFLARE_API_TOKEN = "your-token-here"
```
## Zone Defaults
All Zones will have certasin attributes and resources configured by default. Some can be overridden, others cannot.
1. Creation of 2 Firewall rules. Allow inbound access from external Vuln scanners(this is used for vulnerability reporting) and blocking all traffic from a IP Blacklist (Known/Observed malicious activity)
2. Application of 3 [Cloudflare Managed Rulesets](https://support.cloudflare.com/hc/en-us/articles/200172016-Understanding-WAF-managed-rules-Web-Application-Firewall-#4vxxAwzbHx0eQ8XfETjxiN)
    * WAF rulesets are applied in `log` mode. these can be changed in the env specific configs
3. SSL is enabled in `strict` mode.
    * Enforces SSL at the edge, with Trusted certs at origin
4. A root (<domain>.com) and wildcard (*.<domain>.com) certificate is cut for the zone
    * A managed certificate from Digicert is cut with a 365 day expiry.
    * Cloudflare will auto renew 30days prior
5. Always use HTTPS is enabled
6. Automatic HTTPS rewrites are enforced
7. Minimum version of TLS1.2

## Current Supported Features
 * Creation of Zones
 * Creation of records in zones (A, CNAME, TXT, MX & SRV)
 * Creation of Firewall rules using Cloudflares [Rules Language](https://developers.cloudflare.com/ruleset-engine/rules-language/)
 * Creation of Page Rules for manipulating traffic
 * 3 Default WAF packages are applied to the zone in `log` mode. (can be overridden)
 * Support for per Waf Rule overrides on specific URL's
 * Access Gateway Policies
 * Access Application Policies for Gated Access
 * Access Gateway Policies for DNS filtering

## TODO
* N/A