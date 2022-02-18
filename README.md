# CleafyChallenge
The demo app is "SecureApp".  
SecureApp embed the framework from an ignored folder "builds" that is generated when you build the respective aggregates.  
If you don't want to build the xcframework on your own you can just link the release or debug version of the framework from the Output directory.    
The Secure App project is ready to run.

**Quick note for who is looking at this stuff**:
The jailbreak check may be cut off using tools like [frida](https://frida.re), to avoid this you should implement some defense as described [here](https://mobile-security.gitbook.io/mobile-security-testing-guide/ios-testing-guide/0x06j-testing-resiliency-against-reverse-engineering).
