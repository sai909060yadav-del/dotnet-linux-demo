var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
app.UseDefaultFiles();
app.UseStaticFiles();
app.MapGet("/health", () => Results.Ok(new { status = "healthy" }));
app.MapGet("/api/info", () => Results.Ok(new {
    message = "Hello Sai! My Linux deployment update worked.",
    version = "4,0", // Then change this to 2.0, publish again, and refresh.
    os = System.Runtime.InteropServices.RuntimeInformation.OSDescription,
    framework = System.Runtime.InteropServices.RuntimeInformation.FrameworkDescription
}));
app.Run();
