package demoweb.demo.error;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class PageFaultController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request) {

        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

        int statusCode = 500;

        if (status != null) {
            try {
                statusCode = Integer.parseInt(status.toString());
            } catch (Exception ignored) {}
        }

        if (statusCode == 404) return "Customer/PageFault404";
        if (statusCode == 403) return "Customer/PageFault403";
        return "Customer/PageFault500";
    }
}
