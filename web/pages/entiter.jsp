<%@ include file="elements/header.jsp" %>
<%@ include file="elements/sidebars.jsp" %>
<div class="main-panel">
    <div class="main-header">
      <div class="main-header-logo">
        <!-- Logo Header -->
        <div class="logo-header" data-background-color="dark">
          <a href="index.html" class="logo">
            <img
              src="<%= request.getContextPath() %>assets/img/kaiadmin/logo_light.svg"
              alt="navbar brand"
              class="navbar-brand"
              height="20"
            />
          </a>
          <div class="nav-toggle">
            <button class="btn btn-toggle toggle-sidebar">
              <i class="gg-menu-right"></i>
            </button>
            <button class="btn btn-toggle sidenav-toggler">
              <i class="gg-menu-left"></i>
            </button>
          </div>
          <button class="topbar-toggler more">
            <i class="gg-more-vertical-alt"></i>
          </button>
        </div>
        <!-- End Logo Header -->
      </div>
      <!-- Navbar Header -->
      <nav
        class="navbar navbar-header navbar-header-transparent navbar-expand-lg border-bottom"
        style="background-color: #171a38;"
      >
        <div class="container-fluid">
          <nav
            class="navbar navbar-header-left navbar-expand-lg navbar-form nav-search p-0 d-none d-lg-flex"
          >
            
          </nav>

          <ul class="navbar-nav topbar-nav ms-md-auto align-items-center">
           
            <li class="nav-item topbar-user dropdown hidden-caret">
              <a
                class="dropdown-toggle profile-pic"
                data-bs-toggle="dropdown"
                href="#"
                aria-expanded="false"
              >
                <div class="avatar-sm">
                  <img
                    src="<%= request.getContextPath() %>assets/img/profile.jpg"
                    alt="..."
                    class="avatar-img rounded-circle"
                  />
                </div>
                <span class="profile-username">
                  <span class="op-7" style="color: white;">Hi,</span>
                  <span class="fw-bold" style="color: white;">Hizrian</span>
                </span>
              </a>
              
            </li>
          </ul>
        </div>
      </nav>
      <!-- End Navbar -->
    </div>

    <div class="container">
        <div class="page-inner">
          <div class="page-header">
            <h3 class="fw-bold mb-3">Forms</h3>
            <ul class="breadcrumbs mb-3">
              <li class="nav-home">
                <a href="#">
                  <i class="icon-home"></i>
                </a>
              </li>
              <li class="separator">
                <i class="icon-arrow-right"></i>
              </li>
              <li class="nav-item">
                <a href="#">Forms</a>
              </li>
              <li class="separator">
                <i class="icon-arrow-right"></i>
              </li>
              <li class="nav-item">
                <a href="#">Entiter</a>
              </li>
            </ul>
          </div>
          <div class="row">
            <div class="offset-md-2 col-md-8">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title"><h2 class="text-center" style="color: white;">Form Elements</h2></div>
                </div>
                <div class="card-body">
                  <div class="row">
                    <div class="offset-md-3 col-md-6 offset-lg-2 col-lg-8">

                        <div class="row">
                            <div class="col-md-6">
                              <div class="form-group">
                                <label for="email2">Email Address</label>
                                <input
                                  type="email"
                                  class="form-control"
                                  id="email2"
                                  placeholder="Enter Email"
                                />
                                <small id="emailHelp2" class="form-text text-muted">
                                  We'll never share your email with anyone else.
                                </small>
                              </div>
                            </div>
                            <div class="col-md-6">
                              <div class="form-group">
                                <label for="password">Password</label>
                                <input
                                  type="password"
                                  class="form-control"
                                  id="password"
                                  placeholder="Password"
                                />
                              </div>
                            </div>
                          </div>
                     
                   
                     
                  
                      
                   
                      <div class="form-group">
                        <label for="exampleFormControlSelect1"
                          >Example select</label
                        >
                        <select
                          class="form-select"
                          id="exampleFormControlSelect1"
                        >
                          <option>1</option>
                          <option>2</option>
                          <option>3</option>
                          <option>4</option>
                          <option>5</option>
                        </select>
                      </div>
                      <div class="form-group">
                        <label for="exampleFormControlSelect2"
                          >Example multiple select</label
                        >
                        <select
                          multiple
                          class="form-control"
                          id="exampleFormControlSelect2"
                        >
                          <option>1</option>
                          <option>2</option>
                          <option>3</option>
                          <option>4</option>
                          <option>5</option>
                        </select>
                      </div>
                    
                      <div class="form-group">
                        <label for="comment">Comment</label>
                        <textarea class="form-control" id="comment" rows="5">
                        </textarea>
                      </div>
                     
                    

                      <div class="form-group">
                        <label class="form-label">Size</label>
                        <div class="selectgroup w-100">
                          <label class="selectgroup-item">
                            <input
                              type="radio"
                              name="value"
                              value="50"
                              class="selectgroup-input"
                              checked=""
                            />
                            <span class="selectgroup-button">S</span>
                          </label>
                          <label class="selectgroup-item">
                            <input
                              type="radio"
                              name="value"
                              value="100"
                              class="selectgroup-input"
                            />
                            <span class="selectgroup-button">M</span>
                          </label>
                          <label class="selectgroup-item">
                            <input
                              type="radio"
                              name="value"
                              value="150"
                              class="selectgroup-input"
                            />
                            <span class="selectgroup-button">L</span>
                          </label>
                          <label class="selectgroup-item">
                            <input
                              type="radio"
                              name="value"
                              value="200"
                              class="selectgroup-input"
                            />
                            <span class="selectgroup-button">XL</span>
                          </label>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="form-label">Icons input</label>
                        <div class="selectgroup w-100">
                          <label class="selectgroup-item">
                            <input
                              type="radio"
                              name="transportation"
                              value="2"
                              class="selectgroup-input"
                            />
                            <span
                              class="selectgroup-button selectgroup-button-icon"
                              ><i class="icon-screen-smartphone"></i
                            ></span>
                          </label>
                          <label class="selectgroup-item">
                            <input
                              type="radio"
                              name="transportation"
                              value="1"
                              class="selectgroup-input"
                              checked=""
                            />
                            <span
                              class="selectgroup-button selectgroup-button-icon"
                              ><i class="icon-screen-tablet"></i
                            ></span>
                          </label>
                          <label class="selectgroup-item">
                            <input
                              type="radio"
                              name="transportation"
                              value="6"
                              class="selectgroup-input"
                            />
                            <span
                              class="selectgroup-button selectgroup-button-icon"
                              ><i class="icon-screen-desktop"></i
                            ></span>
                          </label>
                          <label class="selectgroup-item">
                            <input
                              type="radio"
                              name="transportation"
                              value="6"
                              class="selectgroup-input"
                            />
                            <span
                              class="selectgroup-button selectgroup-button-icon"
                              ><i class="fa fa-times"></i
                            ></span>
                          </label>
                        </div>
                      </div>
                      
                     
                      <div class="form-group">
                        <label class="form-label">Your skills</label>
                        <div class="selectgroup selectgroup-pills">
                          <label class="selectgroup-item">
                            <input
                              type="checkbox"
                              name="value"
                              value="HTML"
                              class="selectgroup-input"
                              checked=""
                            />
                            <span class="selectgroup-button">HTML</span>
                          </label>
                          <label class="selectgroup-item">
                            <input
                              type="checkbox"
                              name="value"
                              value="CSS"
                              class="selectgroup-input"
                            />
                            <span class="selectgroup-button">CSS</span>
                          </label>
                          <label class="selectgroup-item">
                            <input
                              type="checkbox"
                              name="value"
                              value="PHP"
                              class="selectgroup-input"
                            />
                            <span class="selectgroup-button">PHP</span>
                          </label>
                          <label class="selectgroup-item">
                            <input
                              type="checkbox"
                              name="value"
                              value="JavaScript"
                              class="selectgroup-input"
                            />
                            <span class="selectgroup-button">JavaScript</span>
                          </label>
                        </div>
                      </div>

                    </div>

                    


                  </div>
                </div>
                <div class="card-action">
                  <button class="btn btn-success">Submit</button>
                  <button class="btn btn-danger">Cancel</button>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="row">
            <div class="offset-md-2 col-md-8">
              <div class="card">
                <div class="card-header" style="background-color: #1b1d38;">
                  <div class="card-title" ><h2 class="text-center" style="color: white;">List Entiter</h2></div>
                </div>
                <div class="card-body">
                  <div class="card-sub">
                    <form method="GET" action="/your-filter-endpoint" class="row g-3">
                        <div class="col-md-5">
                          <input type="text" class="form-control" name="filterFirst" placeholder="Filter by First Name">
                        </div>
                        <div class="col-md-5">
                          <input type="text" class="form-control" name="filterLast" placeholder="Filter by Last Name">
                        </div>
                        <div class="col-md-2">
                          <button type="submit" class="btn btn-success">Valider</button>
                        </div>
                      </form>
                  </div>
                  <table class="table table-hover mt-3">
                    <thead>
                      <tr>
                        <th scope="col">#</th>
                        <th scope="col">First</th>
                        <th scope="col">Last</th>
                        <th scope="col">Handle</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td>1</td>
                        <td>Mark</td>
                        <td>Otto</td>
                        <td>@mdo</td>
                      </tr>
                      <tr>
                        <td>2</td>
                        <td>Jacob</td>
                        <td>Thornton</td>
                        <td>@fat</td>
                      </tr>
                      <tr>
                        <td>3</td>
                        <td colspan="2">Larry the Bird</td>
                        <td>@twitter</td>
                      </tr>
                    </tbody>
                  </table>

                    <!-- Pagination -->
        <nav>
            <ul class="pagination justify-content-center">
              <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1">Previous</a>
              </li>
              <li class="page-item active">
                <a class="page-link" href="#">1</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="#">2</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="#">3</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="#">Next</a>
              </li>
            </ul>
          </nav>
                </div>
              </div>
            
              
            </div>
            
          </div>










      </div>
<%@ include file="elements/footer.jsp" %>