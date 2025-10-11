// src/pages/user/User.tsx
import './user.scss';
import { Card } from 'primereact/card';
import { TabView, TabPanel } from 'primereact/tabview';
import UserTable from './table/UserTable';
import { useEffect, useRef, useState } from 'react';
import { Toast } from 'primereact/toast';
import { Dialog } from 'primereact/dialog';
import UserCreate from './form/userCreate';
import UserUpdate from './form/userUpdate';
import { InputText } from 'primereact/inputtext';
import { Button } from 'primereact/button';
import { getAllUsers } from '../../services/userService';

const User = () => {
  const [userData, setUserData] = useState<any[]>([]);
  const [filtered, setFiltered] = useState<any[]>([]);
  const [q, setQ] = useState<string>('');
  const [infoDataUser, setInfoDataUser] = useState<any>({});
  const [userSelected, setUserSelected] = useState<any>({});
  const [visible, setVisible] = useState(false);
  const toast = useRef<Toast | null>(null);

  useEffect(() => {
    getUsers();
  }, []);

  const getUsers = async () => {
    try {
      const rows = await getAllUsers();

      const mapped = rows.map((u) => ({
        user_code: u.user_code,
        user_name: u.user_name,
        user_phone: u.user_phone,
        user_email: u.user_email,
        role_code: u.role_code,
        created_at: u.created_at,
      }));

      setUserData(mapped);
      setFiltered(mapped);
      calcStatistic(mapped);
    } catch (err) {
      console.error('Error fetching users:', err);
    }
  };

  const calcStatistic = (data: any[]) => {
    const now = new Date().getTime();
    const newUsers = data.filter((u) => now - new Date(u.created_at).getTime() < 24 * 3600 * 1000);

    setInfoDataUser({
      total: data.length,
      newUser: newUsers.length,
    });
  };

  const handleSearch = (e: any) => {
    const kw = e.target.value.toLowerCase().trim();
    setQ(kw);
    if (!kw) return setFiltered(userData);
    setFiltered(userData.filter((x) => String(x.user_code).toLowerCase().includes(kw)));
  };

  const clearSearch = () => {
    setQ('');
    setFiltered(userData);
  };

  const handleSelect = (user: any) => {
    setUserSelected(user);
    setVisible(true);
  };

  return (
    <>
      <TabView>
        {/* TAB 1: DANH SÁCH NHÂN VIÊN */}
        <TabPanel header="List Employee">
          <div className="employee-container">
            {/* --- KHỐI THỐNG KÊ --- */}
            <div className="employee-header">
              <Card>
                <div className="card-body pointer">
                  <span className="card-body-name fs-l">Total Employee</span>
                  <span className="card-body-content fs-2xl">{infoDataUser.total || 0}</span>
                </div>
              </Card>
              <Card>
                <div className="card-body pointer">
                  <span className="card-body-name fs-l">New Employee</span>
                  <span className="card-body-content fs-2xl">{infoDataUser.newEmployee || 0}</span>
                </div>
              </Card>
              <Card>
                <div className="card-body pointer">
                  <span className="card-body-name fs-l">Male</span>
                  <span className="card-body-content fs-2xl">{infoDataUser.male || 0}</span>
                </div>
              </Card>
              <Card>
                <div className="card-body pointer">
                  <span className="card-body-name fs-l">Female</span>
                  <span className="card-body-content fs-2xl">{infoDataUser.female || 0}</span>
                </div>
              </Card>
            </div>

            {/* --- THANH TÌM KIẾM --- */}
            <Card className="search-card">
              <div className="search-bar">
                <span className="p-input-icon-left">
                  <i className="pi pi-search" />
                  <InputText
                    value={q}
                    onChange={handleSearch}
                    placeholder="Search by Employee ID (e.g., AD0001)"
                  />
                </span>
                <Button
                  label="Clear"
                  className="p-button-secondary p-button-sm clear-button"
                  onClick={clearSearch}
                  type="button"
                />
              </div>
            </Card>

            {/* --- BẢNG NHÂN VIÊN --- */}
            <div className="employee-table">
              <Card>
                <UserTable data={filtered} onDelete={getUsers} onSelect={handleSelect} />
              </Card>
            </div>
          </div>
        </TabPanel>

        {/* TAB 2: THÊM NHÂN VIÊN */}
        <TabPanel header="Add Employee">
          <div className="employee-form-card">
            <Card>
              <UserCreate onSuccess={getUsers} />
            </Card>
          </div>
        </TabPanel>
      </TabView>

      {/* POPUP CHỈNH SỬA NHÂN VIÊN */}
      <Dialog
        header="Edit Employee"
        visible={visible}
        style={{ width: '50vw' }}
        onHide={() => setVisible(false)}
      >
        <UserUpdate data={userSelected} closeModal={() => setVisible(false)} getUser={getUsers} />
      </Dialog>

      <Toast ref={toast} />
    </>
  );
};

export default User;
