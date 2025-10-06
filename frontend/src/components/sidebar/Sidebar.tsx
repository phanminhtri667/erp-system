// frontend/src/components/sidebar/Sidebar.tsx
import "./Sidebar.scss";
import logo from "../../assets/images/icons8-logo.svg";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
    faMagnifyingGlass,
    faCalendarDays,
    faEllipsis,
    faArrowRight,
    faSun,
    faUserGear,
    faGear,
    faBarsStaggered,
} from "@fortawesome/free-solid-svg-icons";
import {
    faComment,
    faAddressCard,
    faFolder,
    faHardDrive,
    faCopyright,
    faChartBar,
    faRectangleList,
    faClone,
    faMap,
    faImage,
} from "@fortawesome/free-regular-svg-icons";
import { faAlgolia } from "@fortawesome/free-brands-svg-icons";
import { Link, useLocation } from "react-router-dom";

//them
import { useSelector } from "react-redux";

type Role = "role_1" | "role_2" | "role_3" | undefined;

type MenuItem = {
  key: string;
  name: string;
  path: string;
  icon: any;
};

const menus: MenuItem[] = [
  { key: "dashboard",  name: "Dashboard",  path: "/dashboard",  icon: faChartBar }, // ✅ /dashboard mới đúng
  { key: "employee",   name: "Employee",   path: "/employee",   icon: faAddressCard },
  { key: "timekeeping",name: "Timekeeping",path: "/timekeeping",icon: faCalendarDays },
  { key: "payroll",    name: "Payroll",    path: "/payroll",    icon: faHardDrive },
  { key: "department", name: "Department", path: "/department", icon: faFolder },
];

const canSee = (item: MenuItem, role: Role) => {
  if (role === "role_1") return true; // admin: thấy tất cả
  if (role === "role_2") return item.name !== "Department";
  if (role === "role_3") return !["Department", "Employee"].includes(item.name);
  return true; // mặc định: cứ cho thấy (tránh bị ẩn hết nếu role chưa load)
};
const Sidebar = () => {
    // const
    const userRole = useSelector((state: any) => state.auth.user?.role_code);
    console.log("ROLE CODE:", userRole);  // 👈 kiểm tra đã lấy được chưa

    const location = useLocation();

    return (
        <>
            <div className="sidebar-container">
                <div className="sidebar-sub">
                    <div className="logo">
                        <img src={logo} alt="logo" />
                    </div>

                    <div className="list-icon">
                        <div className="list-icon-item pointer">
                            <FontAwesomeIcon icon={faMagnifyingGlass} />
                        </div>
                        <div className="list-icon-item pointer">
                            <FontAwesomeIcon icon={faCalendarDays} />
                        </div>
                        <div className="list-icon-item pointer">
                            <FontAwesomeIcon icon={faAddressCard} />
                        </div>
                        <div className="list-icon-item pointer">
                            <FontAwesomeIcon icon={faComment} flip="horizontal" />
                        </div>
                        <div className="list-icon-item pointer">
                            <FontAwesomeIcon icon={faFolder} />
                        </div>
                    </div>

                    <div className="sidebar-sub-config">
                        <div className="list-icon-item spin pointer">
                            <FontAwesomeIcon icon={faGear} />
                        </div>
                        <div className="list-icon-item pointer">
                            <FontAwesomeIcon icon={faUserGear} />
                        </div>
                    </div>
                    <div className="sidebar-sub-toggle">
                        <div className="list-icon-item pointer">
                            <FontAwesomeIcon icon={faBarsStaggered} />
                        </div>
                    </div>
                </div>

                <div className="sidebar-menu">
                    <div className="logo pointer">
                        <span>Epic HR</span>
                    </div>
                    <div className="menu">
                        <p>DIRECTORIES</p>
                        <span>HRMS</span>

                        {menus
                            .filter((m) => canSee(m, userRole))
                            .map((item) => {
                            const isActive = location.pathname.startsWith(item.path); // tốt hơn so sánh exact
                            return (
                                <Link
                                key={item.key}
                                to={item.path}
                                className={`menu-item pointer ${isActive ? "menu-active" : ""}`}
                                >
                                <p>
                                    <FontAwesomeIcon
                                    icon={isActive ? faArrowRight : faEllipsis}
                                    className="menu-item-icon"
                                    />
                                    {item.name}
                                </p>
                                </Link>
                            );
                            })}
                    </div>
                    <div className="menu-plus">
                        <div className="menu-plus-wrap">
                            <span>
                                <p className="menu-item pointer ">
                                    <FontAwesomeIcon
                                        icon={faAlgolia}
                                        className="menu-item-icon"
                                    />
                                    Project
                                </p>
                                <p className="menu-item pointer ">
                                    <FontAwesomeIcon
                                        icon={faHardDrive}
                                        className="menu-item-icon"
                                    />
                                    Job Portal
                                </p>
                                <p className="menu-item pointer ">
                                    <FontAwesomeIcon icon={faSun} className="menu-item-icon" />
                                    Authentication
                                </p>
                            </span>
                        </div>
                        <div className="menu-plus-wrap">
                            <p className="menu-plus-heading">UI ELEMENT</p>
                            <span>
                                <p className="menu-item pointer ">
                                    <FontAwesomeIcon
                                        icon={faCopyright}
                                        className="menu-item-icon"
                                    />
                                    Icon
                                </p>
                                <p className="menu-item pointer ">
                                    <FontAwesomeIcon
                                        icon={faChartBar}
                                        rotation={270}
                                        className="menu-item-icon"
                                    />
                                    Chart
                                </p>
                                <p className="menu-item pointer ">
                                    <FontAwesomeIcon
                                        icon={faRectangleList}
                                        rotation={270}
                                        className="menu-item-icon"
                                    />
                                    Forms
                                </p>
                                <p className="menu-item pointer ">
                                    <FontAwesomeIcon icon={faClone} className="menu-item-icon" />
                                    Table
                                </p>
                                <p className="menu-item pointer ">
                                    <FontAwesomeIcon icon={faMap} className="menu-item-icon" />
                                    Map
                                </p>
                                <p className="menu-item pointer ">
                                    <FontAwesomeIcon icon={faImage} className="menu-item-icon" />
                                    Gallery
                                </p>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
};

export default Sidebar;
