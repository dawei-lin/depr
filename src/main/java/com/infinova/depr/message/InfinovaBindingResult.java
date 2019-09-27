package com.infinova.depr.message;

import java.util.List;

public class InfinovaBindingResult {

    private boolean hasError = false;
    private List<InfinovaError> errors;

    public List<InfinovaError> getErrors() {
        return errors;
    }

    public boolean hasErrors() {
        return hasError;
    }

    public void setErrors(List<InfinovaError> errors) {
        if (null != errors && errors.size() > 0) {
            hasError = true;
        }
        this.errors = errors;
    }

}
