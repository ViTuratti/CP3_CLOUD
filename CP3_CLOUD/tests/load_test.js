import http from 'k6/http';
import { sleep, check } from 'k6';

export let options = {
  stages: [
    { duration: '1m', target: 10 },   // Aumenta para 10 usuários em 1 minuto
    { duration: '5m', target: 10 },   // Mantém 10 usuários por 5 minutos
    { duration: '1m', target: 50 },   // Aumenta para 50 usuários em 1 minuto
    { duration: '5m', target: 50 },   // Mantém 50 usuários por 5 minutos
    { duration: '1m', target: 100 },  // Aumenta para 100 usuários em 1 minuto
    { duration: '5m', target: 100 },  // Mantém 100 usuários por 5 minutos
    { duration: '1m', target: 0 },    // Reduz para 0 usuários em 1 minuto
  ],
  thresholds: {
    'http_req_duration': ['p(95)<500'], // 95% das requisições devem ser abaixo de 500ms
  },
};

export default function () {
  let url = 'http://SEU-DNS-DO-ALB/'; // Substitua pelo seu DNS do ALB

  let res = http.get(url);

  check(res, {
    'status é 200': (r) => r.status === 200,
  });

  sleep(1);
}
