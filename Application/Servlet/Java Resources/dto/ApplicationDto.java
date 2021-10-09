package dto;

public class ApplicationDto {

    private String name;
    private String phone;
    private String email;
    private String degree;
    private String courses;
    private String choose;
    private String agreement;

    public void setName(String name) { 
        this.name = name;
    }

    public String getName() { 
        return name;
    }

    public void setPhone(String phone) { 
        this.phone = phone;
    }

    public String getPhone() { 
        return phone;
    }

    public void setEmail(String email) { 
        this.email = email;
    }

    public String getEmail() { 
        return email;
    }

    public void setDegree(String degree) { 
        this.degree = degree;
    }

    public String getDegree() { 
        return degree;
    }

    public void setCourses(String courses) { 
        this.courses = courses;
    }

    public String getCourses() { 
        return courses;
    }

    public void setChoose(String choose) { 
        this.choose = choose;
    }

    public String getChoose() { 
        return choose;
    }

    public void setAgreement(String agreement) { 
        this.agreement = agreement;
    }

    public String getAgreement() { 
        return agreement;
    }
}
