package com.example.androidviews

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentTransaction
import com.example.androidviews.databinding.ActivityMainBinding
import com.example.androidviews.databinding.FragmentFirstBinding
import com.example.androidviews.databinding.FragmentSecondBinding
import com.example.androidviews.databinding.FragmentThirdBinding

class MainActivity : AppCompatActivity() {

    private var contadorValue = 0
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        val firstFragment = FirstFragment()
        val secondFragment = SecondFragment()
        val thirdFragment = ThirdFragment()

        setCurrentFragment(firstFragment)


        enableEdgeToEdge()
        setContentView(binding.root)

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        val contador = binding.activityMainCountValue
        val botaoSomar = binding.activityMainIncrementButton
        val botaoSubtrair = binding.activityMainDecrementButton

        val navbar = binding.bottomNavigationView

        navbar.setOnItemSelectedListener() {
            when(it.itemId){
                R.id.profile -> setCurrentFragment(firstFragment)
                R.id.home -> setCurrentFragment(secondFragment)
                R.id.settings -> setCurrentFragment(thirdFragment)
            }
            true
        }


        botaoSomar.setOnClickListener {
            contador.text = "${++contadorValue}"
        }

        botaoSubtrair.setOnClickListener {
            contador.text = "${--contadorValue}"
        }
    }
    private fun setCurrentFragment(fragment: Fragment) {
        supportFragmentManager.beginTransaction()
            .replace(R.id.flFragment, fragment)
            .commit()
    }
}